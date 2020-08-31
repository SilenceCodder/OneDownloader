import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';
import 'package:onedownloader/service/navigation_service.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   //final NavigationService _navigationService = locator<NavigationService>();
   
  int page = 0;
  UpdateType updateType;
  static final style = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  final pages = [
 Container(
      color: AppColor2.rimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/image/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Hi",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "It's Me",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Sahdeep",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/image/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Take a",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "look at",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Liquid Swipe",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/image/1.png', //assets/image/
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Liked?",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Fork!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Give Star!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          
         
         ),
                             GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 50,
                          child: Material(
                          child: Center(
                            child: Text(('Proceed'),  //model.isPropertyRulesSet ? 'Complete' : 'Skip' If all field is entered, Display complete else Skip
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          color: Color(0xFF45A1C9),
                          shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: AppColor.rimary)
    ),  ),
                        ),
                      ),
                      onTap: (){
                    //    _navigationService.navigateTo(dashboardRoute);
                //                    Navigator.push(context, MaterialPageRoute(
                //  builder: (context) => DashboardScreen(),));
                      },
                    ),
        ],
      ),
    ),
 
          ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            body: LiquidSwipe(
          pages: pages,
          onPageChangeCallback: (value) {
            print('Invalid $value');
          },
          fullTransitionValue: 500,
          enableSlideIcon: true,
        )));
  }
}
