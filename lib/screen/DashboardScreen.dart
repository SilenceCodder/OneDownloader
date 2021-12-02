import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/model/advertSliderModel.dart';
import 'package:onedownloader/Service/Api.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppText.dart';
import 'package:onedownloader/service/push_Notification.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/CategoryTextView.dart';
import 'package:onedownloader/widget/CategoryWidgets.dart';
import 'package:onedownloader/widget/CategoryWidgets2.dart';
import 'package:onedownloader/widget/CategoryWidgets3.dart';
import 'package:onedownloader/widget/SliderImage.dart';
import 'package:onedownloader/widget/UpdateAppDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class DashboardScreen extends StatefulWidget {
  final String advertType;
  const DashboardScreen({this.advertType});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> topBarAnimation;
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String formattedDate;
  Future<AdvertSliderModel> _futueAdverImage;
  final PushNotification _pushNotification = locator<PushNotification>();
  var advertImage;
  final CustomFunction _customFunction = locator<CustomFunction>();
   BannerAd _bannerAd;

  @override
  void initState() {
 //   _futueAdverImage = API().getAdvertImageData();
    todaysDate();
     FirebaseAdMob.instance.initialize(appId: AppText.appID);
    _bannerAd = createBannerAd()..load();
    _bannerAd.show();
    initialized();
    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

     FirebaseAdMob.instance.initialize(appId: AppText.appID);
    _bannerAd = createBannerAd()..load();
    _bannerAd.show();
    super.initState();
  }

  void addAllListData() {
    var count = 9;
    // listViews.add(
    //   SizedBox(height: 10,)
    // );
    listViews.add(
      SliderImage(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
        futueAdverImage:  (widget.advertType != null ? null : _futueAdverImage),
      ),
    );
    listViews.add(
      CategorytitleView(
        titleTxt: 'Apps',
        subTxt: '',
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );
    listViews.add(
      CategoryWidgets(
        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * 4, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: animationController,
      ),
    );

    listViews.add(
      CategoryWidgets2(
        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * 4, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: animationController,
      ),
    );
    listViews.add(
      CategorytitleView(
        titleTxt: 'Others',
        subTxt: '',
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );
    listViews.add(
      CategoryWidgets3(
        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * 4, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          getAppBarUI(),
          getMainListViewUI(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.header,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color:
                              AppColor.header.withOpacity(0.4 * topBarOpacity),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(AppText.appName,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 0.27,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text((formattedDate == null ? '' : formattedDate),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 0.27,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              onTap: () {
                                updateDialog(context);
                               
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  todaysDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMMM');
    formattedDate = formatter.format(now);
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }


initialized() async {
    await _pushNotification.initialise();
    await getVersion();
  }
  
getVersion() async {
    //Fetch client token and store..
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    var result;

    try {
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
      await remoteConfig.fetch(expiration: const Duration(seconds: 10));
      await remoteConfig.activateFetched();
      var result = remoteConfig.getString('Onedownloder_version'); //Firebase config Name
      // advertImage =  remoteConfig.getString('advertImage'); 
      // print('Result is ${advertImage.toString()}');
      // _customFunction.saveAdvertType(advertStatus: advertImage); // Advert Status....

      if (result.toString() == '1.0') {
      } else {
        updateDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    return result;
  }

  //UPDATE DIALOG
  updateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateAppDialog(
              color: AppColor.rimary,
              title: 'Update',
              buttonText: 'OK',
              subtitile: 'A new version is available, update the app to enjoy more features');
        });
  }


BannerAd createBannerAd() {
   MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true, 
     testDevices: <String>["C90313AF7806813367ABF0BBA5D00C05"],
  );

    return BannerAd(
      adUnitId: AppText.bannerId,//BannerAd.testAdUnitId,
      //TODO REMOVE TEST Ads when going to Live
      // AppText.bannerId,
      size: AdSize.banner,
       targetingInfo: targetingInfo,
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


}
