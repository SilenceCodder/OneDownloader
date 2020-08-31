import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/service/navigation_service.dart';
import 'package:onedownloader/styles/AppText.dart';

class BannerAdsScreen extends StatefulWidget {
  @override
  _BannerAdsScreenState createState() => _BannerAdsScreenState();
}

class _BannerAdsScreenState extends State<BannerAdsScreen> {
 BannerAd _bannerAd;
 NavigationService _navigationService = locator<NavigationService>();
 
  @override
  void initState() {
     FirebaseAdMob.instance.initialize(appId: AppText.appID);
    _bannerAd = createBannerAd()..load();
    _bannerAd.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center()
    );
  }

   BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      //TODO REMOVE TEST Ads when going to Live
      // AppText.bannerId,
      size: AdSize.banner,
      //targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if(event == MobileAdEvent.closed){
     //_navigationService.navigateTowithoutBack(homePageRoute);

        }else if(event == MobileAdEvent.failedToLoad){
          //Relaod this page
         //  _navigationService.navigateTowithoutBack(fullAdscreenRoute);
        }
      },
    );
  }

   @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

}