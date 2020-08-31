import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/Ads/FullAdsScreen.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';
import 'package:onedownloader/service/DynamicLinkService.dart';
import 'package:onedownloader/styles/AppImage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
 
  @override
  void initState() {
    initalized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSplash(
        imagePath: AppImage.logo,
        backGroundColor: Colors.white,
        animationEffect: 'top-down',
        logoSize: 200,
        home: FullAdsScreen(pageTogo: DashboardScreen(),), //MyKFmainWidget(),
        //customFunction: duringSplash,
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        //outputAndHome: op,
    );
  }

  initalized()async{
     await _dynamicLinkService.handleDynamicLinks();
  }
}