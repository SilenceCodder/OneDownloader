import 'package:onedownloader/screen/AboutDeveloper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/model/Data.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/UpdateAppDialog.dart';

class CategoryWidgets2 extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const CategoryWidgets2(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  @override
  _CategoryWidgets2State createState() => _CategoryWidgets2State();
}
final CustomFunction _customFunction = locator<CustomFunction>();
class _CategoryWidgets2State extends State<CategoryWidgets2>
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
              height: MediaQuery.of(context).size.height / 6,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: getCategoryList2().length,
                padding: const EdgeInsets.only(top: 0, bottom: 0, right: 3, left: 3),
                itemBuilder: (context, index) {
                  var count = getCategoryList2().length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return CategoryView(
                    iconLink: getCategoryList2()[index].image,
                    id: index,
                    name: getCategoryList2()[index].name,
                    animation: animation,
                    icon: getCategoryList2()[index].icon,
                    color: getCategoryList2()[index].color,
                    iconColor: getCategoryList()[index].iconColor,
                    url: getCategoryList2()[index].webUrl,
                     isImage:getCategoryList2()[index].isImage,
                    image:getCategoryList2()[index].image,
                    animationController: animationController,
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
    this.isImage,
    this.image,
    this.url,
    this.iconColor,
    this.color,
    this.icon,
    this.id,
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
                            child:(isImage == null || !isImage ? Icon(
                              icon,
                              color: iconColor,
                            ): Image.asset(image) ),
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
     print(id);
     if(id == 4){
 String url =
        'https://play.google.com/store/apps/details?id=com.skite.onedownloader';
    _customFunction.launchURL(url);

     }else if(id == 5){
     Navigator.push(context, MaterialPageRoute(
                builder: (context) => AboutDeveloper(),));
     }else{
final CustomFunction _customFunction = locator<CustomFunction>();
     _customFunction.toastMessage(message: 'Coming Soon!');
     }
      
}

}
