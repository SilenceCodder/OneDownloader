import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/Facebook/DowloadFacebook.dart';
import 'package:onedownloader/screen/Facebook/FacebookDownloads.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';

Directory dir = Directory('/storage/emulated/0/${AppText.appName}/Facebook');
Directory thumbDir = Directory('/storage/emulated/0/.${AppText.appName}/.thumbs');

class FacebookScreen extends StatefulWidget {
  @override
  _FacebookScreenState createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen> {
   final CustomFunction _customFunction = locator<CustomFunction>();
 
  @override
  void initState() {
    super.initState();
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
                 child: _customFunction.screenAppBar(screenName: "Facebook", context: context, 
                 tab1name: "Downloader", tab2name: "Downloads"),
         ),
        body: TabBarView(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 1, ),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                         child: DowloadFacebook(dir: dir, thumbDir: thumbDir,),
                       ),
                       )
                     ],)
                   ),
Padding(
                     padding: const EdgeInsets.only(top: 1, left: 5.0, right: 5.0),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, ),
                         child: FacebookDownloads(dir: dir, thumbDir: thumbDir,)
                       ),
                       )
                     ],)
                   ),
                ]),
      ),
    );
  }

}