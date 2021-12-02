import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/model/Data.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppTextStyle.dart';
import 'package:onedownloader/screen/AboutDeveloper.dart';
import 'package:onedownloader/screen/Ads/FullAdsScreen.dart';
import 'package:onedownloader/screen/Facebook/FacebookScreen.dart';
import 'package:onedownloader/screen/TitTok/tiktokDownloadScreen.dart';
import 'package:onedownloader/screen/instagram/mainInstragramScreen.dart';
import 'package:onedownloader/screen/whatsapp/ShowsScreen.dart';
import 'package:onedownloader/utils/customFunction.dart';

class CategoryWidgets extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const CategoryWidgets(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  @override
  _CategoryWidgetsState createState() => _CategoryWidgetsState();
}

class _CategoryWidgetsState extends State<CategoryWidgets>
    with TickerProviderStateMixin {
  AnimationController animationController;
  

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: getCategoryList().length,
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, right: 3, left: 3),
                itemBuilder: (context, index) {
                  var count = getCategoryList().length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return CategoryView(
                    iconLink: getCategoryList()[index].image,
                    id: index,
                    name: getCategoryList()[index].name,
                    icon: getCategoryList()[index].icon,
                    iconColor: getCategoryList()[index].iconColor,
                    url: getCategoryList()[index].webUrl,
                    animation: animation,
                    color: getCategoryList()[index].color,
                    animationController: animationController,
                    isImage:getCategoryList()[index].isImage,
                    image:getCategoryList()[index].image,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class CategoryView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final bool changeColor;
  final String iconLink, name, url, image;
  final int id;
  final Color color, iconColor;
  final IconData icon;
  final bool isImage;

  const CategoryView({
    Key key,
    this.animationController,
    this.iconLink,
    this.name,
    this.image,
    this.url,
    this.color,
    this.iconColor,
    this.icon,
    this.id,
    this.isImage,
    this.animation,
    this.changeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Material(
                        elevation: 5,
                        shape: CircleBorder(),
                        shadowColor: AppColor
                            .rimary, //ChangeColor(transaction[index].network).withOpacity(0.4),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: (isImage == null || !isImage ? Icon(
                              icon,
                              color: iconColor,
                            ): Image.asset(image,) ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(name + ' ›',
                        style: AppTextStyle.subheader3(context, Colors.black))
                  ],
                ),
              ),
              onTap: () {
              whenIndexClicked(context);
              },
            ),
          ),
        );
      },
    );
  }

  whenIndexClicked(BuildContext context) {
    if (id == 0) { //Facebook
      print('Here');
      //FACEBOOK
  Navigator.push(context, MaterialPageRoute(
                builder: (context) => FullAdsScreen(pageTogo: FacebookScreen(),),));
                // Navigator.push(context, MaterialPageRoute(
                // builder: (context) => FacebookScreen(),));
              
  }else if(id == 1){ //Whatsapp
                  Navigator.push(context, MaterialPageRoute(
                builder: (context) => FullAdsScreen(pageTogo:ShowsScreen(title: 'Whatsapp Status', path: '',),)));

  }else if(id == 2){ //Instragm
                 Navigator.push(context, MaterialPageRoute(
                builder: (context) => FullAdsScreen(pageTogo: MainInstragramScreen(),),));
                

  }else if(id == 3){ //TickTok
  Navigator.push(context, MaterialPageRoute(
                builder: (context) => FullAdsScreen(pageTogo: TiktokDownload(),),));
                

  }else if(id == 4){ //Twitter
  final CustomFunction _customFunction = locator<CustomFunction>();
  _customFunction.toastMessage(message: 'Coming Soon!');
  }
}
}
