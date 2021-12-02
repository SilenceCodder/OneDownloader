import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';
import 'package:onedownloader/service/navigation_service.dart';
import 'package:onedownloader/service/push_Notification.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
  NavigationService _navigationService = locator<NavigationService>();
   //CustomFunction _customFunction = locator<CustomFunction>();
   
class _SplashScreenState extends State<SplashScreen> {
   final PushNotification _pushNotification = locator<PushNotification>();
  
  

   final pages = [
 Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [AppColor.b1, AppColor.b11],
          tileMode: TileMode.repeated
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.d,//board1,
            fit: BoxFit.cover,
            height: 500,
            width: 500
          //  height: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                    "Stop consuming your phone memory with alot of Downloader Apps, One Downloader is here",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sura(
                        fontSize: AppFontSizes.medium,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColor.white
                        )
                    )
              ),
                 ),
               ),

            ],
          )
        ],
      ),
    ),
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.b21, AppColor.b2],
              tileMode: TileMode.repeated
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.board2,
             fit: BoxFit.cover,
            height: 500,
            width: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Download your social media video, photos and audio with one Click.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sura(
                          fontSize: AppFontSizes.medium,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.white
                          )
                      )
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    ),

  Container(
    decoration: BoxDecoration(
        gradient: AppColor.primaryGradient
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.board4,
            fit: BoxFit.cover,
            height: 500,
            width: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Just copy your link and paste on the App, we will do the rest.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sura(
                          fontSize: AppFontSizes.medium,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.white
                          )
                      )
                  ),
                ),
              ),

            ],
          ),       
                     GestureDetector(
                      onTap: () async{
                       _navigationService.navigateTo(dashboardRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0 ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 16),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 10),
                              ]),
                          child: Text(
                            "Proceed",
                            style: GoogleFonts.alef(
        fontSize: AppFontSizes.large2, textStyle: TextStyle(color: Colors.white)
                          ),)
                        ),
                      ),
                    ),
        ],
      ),
    ),
   ];

  
  @override
  void initState() {
    initalized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
        body: LiquidSwipe(
            pages: p(context),
            slideIconWidget: Icon(Icons.arrow_forward, color: Colors.white, size: 30,),
            onPageChangeCallback: (value) {
              print('Invalid $value');
            },
            fullTransitionValue: 500,
            enableSlideIcon: true,
        )));
  }
  
  initalized()async{
    await _pushNotification.initialise(); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(onboard, "1");
 }

 p(BuildContext context){
   return [
 Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [AppColor.b1, AppColor.b11],
          tileMode: TileMode.repeated
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.d,//board1,
            fit: BoxFit.cover,
            height: 500,
            width: 500
          //  height: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                    "Stop consuming your phone memory with alot of Downloader Apps, One Downloader is here",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sura(
                        fontSize: AppFontSizes.medium,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColor.white
                        )
                    )
              ),
                 ),
               ),

            ],
          )
        ],
      ),
    ),
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.b21, AppColor.b2],
              tileMode: TileMode.repeated
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.board2,
             fit: BoxFit.cover,
            height: 500,
            width: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Download your social media video, photos and audio with one Click.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sura(
                          fontSize: AppFontSizes.medium,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.white
                          )
                      )
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    ),

  Container(
    decoration: BoxDecoration(
        gradient: AppColor.primaryGradient
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            AppImage.board4,
            fit: BoxFit.cover,
            height: 500,
            width: 500
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Just copy your link and paste on the App, we will do the rest.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sura(
                          fontSize: AppFontSizes.medium,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.white
                          )
                      )
                  ),
                ),
              ),

            ],
          ),       
                     GestureDetector(
                      onTap: () async{
                     //  _navigationService.navigateTo(dashboardRoute);
                        Navigator.push(context, MaterialPageRoute(
                builder: (context) => DashboardScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0 ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 16),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 10),
                              ]),
                          child: Text(
                            "Proceed",
                            style: GoogleFonts.alef(
        fontSize: AppFontSizes.large2, textStyle: TextStyle(color: Colors.white)
                          ),)
                        ),
                      ),
                    ),
        ],
      ),
    ),
   ];
 }
}