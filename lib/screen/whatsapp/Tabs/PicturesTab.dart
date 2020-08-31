import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onedownloader/screen/whatsapp/PreviewDownloadImage.dart';
import 'package:permission_handler/permission_handler.dart';

class PicturesTab extends StatelessWidget {
   Directory dir;
 PicturesTab({this.dir});


@override
  Widget build(BuildContext context) {
  

   if(!Directory("${dir.path}").existsSync()) {
     print(Directory("${dir.path}").existsSync());
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
      var imageList = dir.listSync().map((item) => item.path).where((
          item) => item.endsWith(".jpg")).toList(growable: false);

      if (imageList.length > 0) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(bottom: 60.0),
            child: GridView.builder(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: imageList.length,
                      itemBuilder: (context, index){
                        String imgPath = imageList[index];
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
    pageBuilder: (_, __, ___) => PreviewDownloadImage(imagePath: imgPath,),
  ),
);
                            },
                            child: Hero(
                              tag: imgPath,
                              transitionOnUserGestures: true,
                              child: Image.file(
                                File(imgPath),
                                fit: BoxFit.cover,
                              ),
                            ),
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
        return Scaffold(
         
          body: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text("Sorry, No Images Where Found.", style: TextStyle(
                  fontSize: 18.0
              ),),
            ),
          ),
        );
      }
    }
  }


}
