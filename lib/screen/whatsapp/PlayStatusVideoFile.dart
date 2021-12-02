import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/StatusVideoWidget.dart';
import 'package:video_player/video_player.dart';

class PlayStatusVideoFile extends StatefulWidget {
   final String videoFile,  indexHero; bool isWhatsapp;

  PlayStatusVideoFile({this.videoFile, this.indexHero, this.isWhatsapp});
  @override
  _PlayStatusVideoFileState createState() => _PlayStatusVideoFileState();
}

class _PlayStatusVideoFileState extends State<PlayStatusVideoFile> {
  final CustomFunction _customFunction = locator<CustomFunction>();
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
                backgroundColor: AppColor.rimary,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.white,),
                  onTap: (){
                     Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  GestureDetector(
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.dev, size: 30, color:  AppColor.primaryLight,),
                    ),
                    onTap: (){
              //_navigationService.navigateTo(settingRoute);
                    },
                  )
                ],
                title:  Text(AppText.appName, 
                style:  TextStyle(
              color: Colors.white,
              fontSize: AppFontSizes.large,
              fontWeight: FontWeight.bold
            )
          ),),
      body: Container(
                    child: StatusVideoWidget(
                  videoPlayerController: VideoPlayerController.file(File(widget.videoFile)), looping: true, videoSrc: widget.videoFile),
         ),
      floatingActionButton: (widget.isWhatsapp  ? SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
        //  visible: _dialVisible,
          // If true user is forced to close dial manually 
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.save),
              backgroundColor: Colors.green,
              label: 'Save',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                saveVideo();
              } 
            ),
          ],
        ) : Container())
    );
 
  }

  saveVideo()async{
GallerySaver.saveVideo(widget.videoFile);
_customFunction.toastMessage(message: "Video Successfully Saved");
  }
}