import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:flutter_share_file/flutter_share_file.dart';

class PreviewDownloadImage extends StatefulWidget {
  final String imagePath;

  const PreviewDownloadImage({this.imagePath});
  @override
  _PreviewDownloadImageState createState() => _PreviewDownloadImageState();
}

class _PreviewDownloadImageState extends State<PreviewDownloadImage> {
  final CustomFunction _customFunction = locator<CustomFunction>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: AppColor.rimary,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.grey,),
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
      body: Column(children: <Widget>[
         Hero(
            tag: widget.imagePath,
            child: Image.file(
              File(widget.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
      ],),
      floatingActionButton: SpeedDial(
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
            // SpeedDialChild(
            //   child: Icon(Icons.share),
            //   backgroundColor: Colors.red,
            //   label: 'Share',
            //   labelStyle: TextStyle(fontSize: 18.0),
            //   onTap: () {
            //    // shareImage();
            //    _customFunction.toastMessage(message: "Coming soon!");
            //   }
            // ),
            // SpeedDialChild(
            //   child: Icon(Icons.mobile_screen_share),
            //   backgroundColor: Colors.blue,
            //   label: 'Repost',
            //   labelStyle: TextStyle(fontSize: 18.0),
            //   onTap: () => _customFunction.toastMessage(message: "Coming soon!")
            // ),
            SpeedDialChild(
              child: Icon(Icons.save),
              backgroundColor: Colors.green,
              label: 'Save',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                saveImage();
              } 
            ),
          ],
        ),
    );
 
  }

  saveImage()async{
GallerySaver.saveImage(widget.imagePath);
_customFunction.toastMessage(message: "Image Successfully Saved");
  }

  shareImage(){
    FlutterShareFile.share(widget.imagePath, widget.imagePath, ShareFileType.image);
  }
}