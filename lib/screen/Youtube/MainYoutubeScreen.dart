import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/Youtube/YoutubeDownloads.dart';
import 'package:onedownloader/screen/Youtube/YoutubeDownloderTab.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';


Directory dir = Directory('/storage/emulated/0/${AppText.appName}/Youtube');
Directory thumbDir = Directory('/storage/emulated/0/.${AppText.appName}/.thumbs');

class MainYoutubeScreen extends StatefulWidget {
  @override
  _MainYoutubeScreenState createState() => _MainYoutubeScreenState();
}

class _MainYoutubeScreenState extends State<MainYoutubeScreen> { //
     final CustomFunction _customFunction = locator<CustomFunction>();

  @override
  void initState() {
    super.initState();
    // ****CREATE DIRECTOY
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    if (!thumbDir.existsSync()) {
      thumbDir.createSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
      ScreenUtil.init(context, width: 1080, height: 2160, allowFontScaling: false); // //For setting up screen unit
    return DefaultTabController(
      length: 2,
          child: Scaffold(
        appBar: PreferredSize(
                 preferredSize: Size.fromHeight(100.0), 
                 child: _customFunction.screenAppBar(screenName: "Youtube", context: context, 
                 tab1name: "Downloader", tab2name: "Downloads"),
         ),
        body: TabBarView(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 1, ),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                         child: YoutubeDownloderTab(dir: dir, thumbDir: thumbDir,),
                       ),
                       )
                     ],)
                   ),
Padding(
                     padding: const EdgeInsets.only(top: 1, left: 5.0, right: 5.0),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, ),
                         child: YoutubeDownloads(dir: dir, thumbDir: thumbDir,)
                       ),
                       )
                     ],)
                   ),
                ]),
      ),
    );
  }


}
