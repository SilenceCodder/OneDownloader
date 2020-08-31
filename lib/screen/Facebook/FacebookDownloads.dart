import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';

class FacebookDownloads extends StatefulWidget {
    final Directory dir, thumbDir;
 const FacebookDownloads({this.dir, this.thumbDir});
  @override
  _FacebookDownloadsState createState() => _FacebookDownloadsState();
}

class _FacebookDownloadsState extends State<FacebookDownloads> {
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
        return Container(
          padding: EdgeInsets.only(bottom: 150.0),
          margin: EdgeInsets.only(left: 8.0, right: 8.0),
          child: GridView.builder(
             padding:EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: fileList.length,
            itemBuilder: (context, index) {
              File file = fileList[index];
              if (_isImage[index] == false) {
                String thumb = fileList[index].toString().replaceAll('File: \'/storage/emulated/0/${AppText.appName}/Facebook/', '');
                thumb = thumb.substring(0, thumb.length - 4) + 'jpg';
                var path = widget.thumbDir.path + '/' + thumb;
                file = File(path);
              }
              return Column(
                children: <Widget>[
                  _isImage[index]
                      ? Container(
                          height: _customFunction.screenWidthSize(120, context),
                          width: _customFunction.screenWidthSize(120, context),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Material(
                             elevation: 8.0,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                           child: Hero(
                              tag:  index.toString(),
                              transitionOnUserGestures: true,
                              child: Image.file(
                               file,
                                fit: BoxFit.cover,
                              ),
                            ) 
                          ),
                        )
                      :  GestureDetector(
                                              child: Material(
                               elevation: 8.0,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                             child: Hero(
                                tag:  index.toString(),
                                transitionOnUserGestures: true,
                                child: Image.file(
                                 file,
                                  fit: BoxFit.cover,
                                ),
                              ) 
                            ),
                            onTap: (){
                              _customFunction.toastMessage(message: 'You can play this on your Video Player', );
                            },
                      ),
                ],
              );
            },
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24.0,
              crossAxisSpacing: 24.0,
              childAspectRatio: 1.0,
                      ),
          ),
        );
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
}