import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:onedownloader/styles/AppText.dart';

class FullAdsScreen extends StatefulWidget {
 final Widget  pageTogo;

const FullAdsScreen({this.pageTogo});
  @override
  _FullAdsScreenState createState() => _FullAdsScreenState();
}

class _FullAdsScreenState extends State<FullAdsScreen> {
InterstitialAd _interstitialAd;
//NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
  FirebaseAdMob.instance.initialize(appId: AppText.appID); //FirebaseAdMob.testAppId
   _interstitialAd = createInterstitialAd()..load();
     _interstitialAd.show();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }

  InterstitialAd createInterstitialAd() {
     MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true, 
     testDevices: <String>["C90313AF7806813367ABF0BBA5D00C05"],
  );

    return InterstitialAd( //C90313AF7806813367ABF0BBA5D00C05
      adUnitId: AppText.interstitialUnit,
      targetingInfo: targetingInfo,
      //TODO REMOVE TEST Ads when going to Live
      //AppText.interstitialUnit,
      listener: (MobileAdEvent event) {
        if(event == MobileAdEvent.closed){
          print('*************Ads close by User**************');
     Navigator.push(context, MaterialPageRoute(
                builder: (context) => widget.pageTogo));
   
        }else if(event == MobileAdEvent.failedToLoad){
           print('****************Ads Failed to load****************');
        Navigator.push(context, MaterialPageRoute(
                builder: (context) => widget.pageTogo));

        }
      },
    );
  }

   @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }
}