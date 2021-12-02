import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onedownloader/screen/instagram/InstagramDownloads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/instagram/InstaDownloder.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';

Directory dir = Directory('/storage/emulated/0/${AppText.appName}/Instagram');
Directory thumbDir = Directory('/storage/emulated/0/.${AppText.appName}/.thumbs');


class MainInstragramScreen extends StatefulWidget {
  @override
  _MainInstragramScreenState createState() => _MainInstragramScreenState();
}

class _MainInstragramScreenState extends State<MainInstragramScreen> { //
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
                 child: _customFunction.screenAppBar(screenName: "Instagram", context: context, 
                 tab1name: "Downloader", tab2name: "Downloads", value: 2),
         ),
        body: TabBarView(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 1, ),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                         child: InstaDownloder(dir: dir, thumbDir: thumbDir,),
                       ),
                       )
                     ],)
                   ),
Padding(
                     padding: const EdgeInsets.only(top: 1, left: 5.0, right: 5.0),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, ),
                         child: InstagramDownloads(dir: dir, thumbDir: thumbDir,)
                       ),
                       )
                     ],)
                   ),
                ]),
      ),
    );
  }


}
