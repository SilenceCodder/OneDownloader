import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/TitTok/DownloadTab.dart';
import 'package:onedownloader/screen/TitTok/ShowTicTokDownloadsTab.dart';
import 'package:onedownloader/screen/TitTok/tiktokData.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/MyButton.dart';
import 'package:progressive_image/progressive_image.dart';

Directory dir = Directory('/storage/emulated/0/${AppText.appName}/Tiktok');
Directory thumbDir = Directory('/storage/emulated/0/.${AppText.appName}/.thumbs');

class TiktokDownload extends StatefulWidget {
  @override
  _TiktokDownloadState createState() => _TiktokDownloadState();
}

class _TiktokDownloadState extends State<TiktokDownload> {
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
                 child: _customFunction.screenAppBar(screenName: "Tiktok", context: context, 
                 tab1name: "Downloader", tab2name: "Downloads", value: 3),
         ),
        body: TabBarView(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 1, ),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                         child: DownloadTab(dir: dir, thumbDir: thumbDir,),
                       ),
                       )
                     ],)
                   ),
Padding(
                     padding: const EdgeInsets.only(top: 1, left: 5.0, right: 5.0),
                     child: Column(children: <Widget>[
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(top: 5.0, ),
                         child: ShowTicTokDownloadsTabs(dir: dir, thumbDir: thumbDir,)
                       ),
                       )
                     ],)
                   ),
                ]),
      ),
    );
  }


}
