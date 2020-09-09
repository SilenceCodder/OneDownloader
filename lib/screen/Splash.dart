import 'package:custom_splash/custom_splash.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/Ads/FullAdsScreen.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';
import 'package:onedownloader/service/DynamicLinkService.dart';
import 'package:onedownloader/service/push_Notification.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/utils/customFunction.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
 final CustomFunction _customFunction = locator<CustomFunction>();
 var advertImage;
 var interstitialUnit;
  final PushNotification _pushNotification = locator<PushNotification>();
  
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
        home: FullAdsScreen(pageTogo: DashboardScreen(advertType: advertImage,),),//DashboardScreen(advertType: advertImage,),
        // (interstitialUnit == null ? DashboardScreen(advertType: advertImage,) 
        // :  FullAdsScreen(pageTogo: DashboardScreen(advertType: advertImage,),)), 
        //customFunction: duringSplash,
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        //outputAndHome: op,
    );
  }

  initalized()async{
     await _pushNotification.initialise();
     await _dynamicLinkService.handleDynamicLinks();
     getAdvertConfig();
  }

  getAdvertConfig() async {
    //Fetch client token and store..
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    var result;

    try {
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
      await remoteConfig.fetch(expiration: const Duration(seconds: 10));
      await remoteConfig.activateFetched();
       advertImage =  remoteConfig.getString('advertImage'); 
       var bannerUnit = remoteConfig.getString('OneDownloader_bannerId'); 
        interstitialUnit = remoteConfig.getString('OneDownloader_interstitialUnit');
       print('BANNER => $bannerUnit'); 
       print('INTERSTIATIL => $interstitialUnit'); 

      _customFunction.saveAdvertType(advertStatus: advertImage, 
      banner: bannerUnit, 
      interstitial: interstitialUnit); // Advert Status....

    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    return result;
  }
}