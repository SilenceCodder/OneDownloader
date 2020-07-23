import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/model/Data.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppTextStyle.dart';

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
                    url: getCategoryList()[index].webUrl,
                    animation: animation,
                    color: getCategoryList()[index].color,
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
  final String iconLink, name, url;
  final int id;
  final Color color;
  final IconData icon;

  const CategoryView({
    Key key,
    this.animationController,
    this.iconLink,
    this.name,
    this.url,
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
                            child: Icon(
                              icon,
                              color: Colors.white,
                            ),
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
              
              },
            ),
          ),
        );
      },
    );
  }

  // whenIndexClicked(BuildContext context) {
  //   if (id == 0) {
  //     //HOME

  //   } else if (id == 1) {
  //     //FEATURED
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => FeaturedScreen()),
  //     );
  //   // } else if (id == 2) {
  //   //   //TRENDING
  //   //   Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(builder: (context) => TrendingScreen()),
  //   //   );
  //   // } else if (id == 3) {
  //   //   //LATEST
  //   //   Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(builder: (context) => LatestNewsScreen()),
  //   //   );
  //   } else if (id == 4) {
  //     //Jobs
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => JobScreen()),
  //     );
  //   }
  // }
}
