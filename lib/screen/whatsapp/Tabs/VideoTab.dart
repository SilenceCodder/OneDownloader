import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onedownloader/screen/whatsapp/PlayStatusVideoFile.dart';
import 'package:onedownloader/screen/whatsapp/PreviewDownloadImage.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoTab extends StatefulWidget {
    Directory dir;
 VideoTab({this.dir});

  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
   VideoPlayerController _controller;

   @override
void initState() {
super.initState();

}

@override
  Widget build(BuildContext context) {

   if(!Directory("${widget.dir.path}").existsSync()) {
     print(Directory("${widget.dir.path}").existsSync());
      return Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text("Path doesn't Exist ", style: TextStyle(
              fontSize: 18.0
            ),),
          ),
        ),
      );
    }else {
          
List<String> videoList =
        widget.dir.listSync().map((item) => item.path).where((item) =>
         item.endsWith(".mp4")).toList(growable: false);

         if (videoList != null) {
      if (videoList.length > 0) {
        return Scaffold(
                  body: Container(
                     padding: EdgeInsets.only(bottom: 60.0),
              child: GridView.builder(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: videoList.length,
                      itemBuilder: (context, index){
                      return Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: InkWell(
                            splashColor: Colors.green,
                            highlightColor: Colors.green,
                            onTap: () {
                             
                  Navigator.push(
                   context,
  PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (_, __, ___) => PlayStatusVideoFile(
      videoFile: videoList[index], 
      indexHero: index.toString(),
      isWhatsapp: true,
    ),
  ),
);
                            },
                            child: FutureBuilder(
                                  future: _getImage(videoList[index]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData) {
                                    return    Hero(
                              tag:  index.toString(),
                              transitionOnUserGestures: true,
                              child: Image.file(
                                File(snapshot.data),
                                fit: BoxFit.cover,
                              ),
                            );
                                      } else {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                    } else {
                                      return Hero(
                                          tag: videoList[index],
                                          child: Container(height: 280.0, child: Image.asset(AppImage.imageloadingGif)));
                                    }
                                  })
                          ),
                          
                        );

                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.0,
                        crossAxisSpacing: 24.0,
                        childAspectRatio: 1.0,
                      ),
                    ),  
                                  ),
        );
      } else {
        return Center(child: Text("Sorry, No Videos Found.", style: TextStyle(fontSize: 18.0)));
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }

    }
  }

  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType: ThumbFormat.PNG, //this image will store in created folderpath
        quality: 10);

    return thumb;
  }
  
}