import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/whatsapp/PlayStatusVideoFile.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:share/share.dart';
import 'package:thumbnails/thumbnails.dart';

class InstagramDownloads extends StatefulWidget {
   final Directory dir, thumbDir;
 const InstagramDownloads({this.dir, this.thumbDir});


  @override
  _InstagramDownloadsState createState() => _InstagramDownloadsState();
}

class _InstagramDownloadsState extends State<InstagramDownloads> {
 List<bool> _isImage = [];
  final CustomFunction _customFunction = locator<CustomFunction>();

  void _checkType() {
    for (var item in widget.dir.listSync()) {
      if (item.toString().endsWith(".jpg'")) {
        _isImage.add(true);
      } else {
        _isImage.add(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.dir.existsSync()) {
      _checkType();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.dir.existsSync()) {
     return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'Sorry, No Downloads Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
    } else {
      var fileList = widget.dir.listSync();
      if (fileList.length > 0) {
        
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
      isWhatsapp: false,
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
    // } else {
    //   return Center(child: CircularProgressIndicator());
    // }

    }
  }
  
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'Sorry, No Downloads Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
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