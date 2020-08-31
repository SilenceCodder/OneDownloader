import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/Youtube/youTubeData.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/MyButton.dart';
import 'package:progressive_image/progressive_image.dart';

class YoutubeDownloderTab extends StatefulWidget {
   final Directory dir, thumbDir;
 const YoutubeDownloderTab({this.dir, this.thumbDir});

  @override
  _YoutubeDownloderTabState createState() => _YoutubeDownloderTabState();
}

class _YoutubeDownloderTabState extends State<YoutubeDownloderTab> {
   var _ytScaffoldKey = GlobalKey<ScaffoldState>();
  YoutubeChannel _ytChannel;
  TextEditingController _urlController = TextEditingController();
  bool _isDisabled = true, _showData = false, _notfirst = false, _isPrivate = false, _hasAudio = false;
   bool _isPasted = true;
  String errorMessage;
   int type;
   final CustomFunction _customFunction = locator<CustomFunction>();

   @override
  void initState() {
    super.initState();
    if (!widget.dir.existsSync()) {
      widget.dir.createSync(recursive: true);
    }
    if (!widget.thumbDir.existsSync()) {
      widget.thumbDir.createSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
              SizedBox(height: 50,),
             Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                   keyboardType: TextInputType.text,
                  controller: _urlController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                       onChanged: (value) {
                    getButton(value);
                  },
                              cursorRadius: Radius.elliptical(10, 20),
                             style: AppTextStyle.inputText(context), //add controller here
                                    decoration:  InputDecoration(
                                      hintText: 'https://www.youtube.com/watch?v=...',
                                  enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: new BorderSide(color: AppColor.primaryColor,
                                  ),
                              ),
                        border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: new BorderSide(color: AppColor.primaryColor
                            ),
                      ),
                        hintStyle: AppTextStyle.subHeader2(context, Colors.grey),
                        prefixIcon: Icon(Icons.file_download, color: Colors.grey, size: 16.0,)
              ),),),
            
            SizedBox(height: 10),
             _customFunction.errorUimessage(errorMessage: errorMessage, type: type, context: context),
             
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                 //** PASTE UI */
               GestureDetector(
                      onTap: () async{
                        if(_isPasted){
                        
                       Map<String, dynamic> result = await SystemChannels.platform.invokeMethod('Clipboard.getData');
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _urlController.text = result['text'].toString(),
                    );
                    setState(() {
                      getButton(result['text'].toString());
                    });
                        }else{
                           //DO NOTHING
                  
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0 ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(120),
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.secondaryLightColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 16),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 10),
                              ]),
                          child: Text(
                            "Paste",
                            style: AppTextStyle.header4(context, (_isPasted ? Colors.white : Colors.grey))
                          ),
                        ),
                      ),
                    ),
                      GestureDetector(
                      onTap: () async{
                        if(_isDisabled){
                          //DO NOTHING
                        }else{
                          //print(_urlController.text);

                        //*** Fetch from URL*/
                         var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult == ConnectivityResult.none) {
                             setErrorMessage(message: "No Internet", t: 0);
                            return;
                          }
                          setState(() {
                            _notfirst = true;
                            _showData = false;
                          });
                          _ytChannel = await YoutubeData.videoFromUrl('${_urlController.text}');
                          if (_ytChannel.videoData.videoInfo[0].videoUrl.length == 4) {
                             setErrorMessage(message: "Check your Url and Try Again!..", t: 0);
                            setState(() {
                              _notfirst = false;
                            });
                            return;
                          }
                          if (_ytChannel.videoData.audioInfo.length == 0) {
                            setState(() {
                              _hasAudio = false;
                            });
                          } else {
                            setState(() {
                              _hasAudio = true;
                            });
                          }
                          setState(() {
                            _showData = true;
                          });
                          // _getDownloadLink();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0 ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(120),
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.primaryDark,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 16),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: AppColor.primaryLight.withOpacity(0.2),
                                    blurRadius: 10),
                              ]),
                          child: Text(
                            "Download",
                            style: AppTextStyle.header4(context, (_isDisabled ? Colors.grey : Colors.white))
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _isPrivate
                ? Text(
                    'This Video is Private',
                    style: TextStyle(fontSize: 14.0),
                  )
                : Container(),
            _notfirst
                ? _showData
                    ? Container(
                        padding: EdgeInsets.only(bottom: 30.0),
                        margin: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: _customFunction.screenHeightSize(375, context),
                          child: GridView.builder(
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              String _postDescription = _ytChannel.videoData.title;
                              return Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: _customFunction.screenHeightSize(200, context),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                        ),
                                        child: ProgressiveImage(
                                          placeholder: AssetImage(AppImage.imageloadingGif),
                                          thumbnail: NetworkImage(_ytChannel.videoData.thumbnail),
                                          image: NetworkImage(_ytChannel.videoData.thumbnail),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.videocam),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 5.0),
                                    child: GestureDetector(
                                      child: Text(
                                        '${_postDescription.length > 100 ? _postDescription.replaceRange(100, _postDescription.length, '') : _postDescription}...',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      onTap: () async {
                                        Clipboard.setData(ClipboardData(text: _postDescription));
                                         _customFunction.toastMessage(message: "Caption Copied");
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: MyButton(
                                      text: 'Download Thumbnail',
                                      padding: EdgeInsets.all(5.0),
                                      color: Theme.of(context).accentColor,
                                      // onPressed: _isDown
                                      //     ? null
                                      //     : () async {
                                      //         var _downloadUrl = _ytChannel.videoData.thumbnail;
                                      //         _downloadDialog(context, _downloadUrl, _ytChannel.videoData.title);
                                      //       },
                                      onPressed: () async {
                                         _customFunction.toastMessage(message: "Added to Download");
                                        String downloadUrl = _ytChannel.videoData.thumbnail;
                                        String name = 'YT-Thumbnail-${_ytChannel.videoData.title}.png';
                                        await FlutterDownloader.enqueue(
                                          url: downloadUrl,
                                          savedDir: widget.dir.path,
                                          fileName: name,
                                          showNotification: true,
                                          openFileFromNotification: true,
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: MyButton(
                                          text: 'Download Audio',
                                          padding: EdgeInsets.all(5.0),
                                          color: Theme.of(context).accentColor,
                                          onPressed: _hasAudio
                                              ? () async {
                                                  _getList('audio', _ytChannel.videoData);
                                                }
                                              : null,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: MyButton(
                                          text: 'Download Video',
                                          padding: EdgeInsets.all(5.0),
                                          color: Theme.of(context).accentColor,
                                          onPressed: () async {
                                            String downloadUrl = _ytChannel.videoData.thumbnail;
                                            String name = '${_ytChannel.videoData.title}.png';
                                            //save video thumbnail
                                            await FlutterDownloader.enqueue(
                                              url: downloadUrl,
                                              savedDir: widget.thumbDir.path,
                                              fileName: name,
                                              showNotification: false,
                                            );
                                            _getList('video', _ytChannel.videoData);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                : Container(),
          ],
        ),
      ),
    );
  }



   void _download(downloadUrl, name) async {
    await FlutterDownloader.enqueue(
      url: downloadUrl,
      savedDir: widget.dir.path,
      fileName: name,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  void _getList(String type, YoutubeVideo data) async {
    String details = '';
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: _customFunction.screenHeightSize(225, context),
            child: ListView.builder(
                itemCount: type == 'audio' ? data.audioInfo.length : data.videoInfo.length,
                itemBuilder: (context, index) {
                  details = type == 'audio' ? data.audioInfo[index].audioBitrate.toString() + ' kbps' : data.videoInfo[index].videoQuality.toString() + '${data.videoInfo[index].hasAudio ? '' : '[ONLY VIDEO]'}';
                  return ListTile(
                    onTap: () async {
                      String url = type == 'audio' ? data.audioInfo[index].audioUrl.toString() : data.videoInfo[index].videoUrl.toString();
                      // _downloadDialog(context, url, data.title + ' $details');
                      String info = type == 'audio' ? data.audioInfo[index].audioBitrate.toString() + ' kbps' : data.videoInfo[index].videoQuality.toString() + '${data.videoInfo[index].hasAudio ? '' : '[ONLY VIDEO]'}';
                      String filename = data.title + ' - $info' + '.${type == 'audio' ? 'mp3' : 'mp4'}';
                      _download(url, filename);
                      Navigator.of(context).pop();
                    },
                    title: Text(data.title + ' - $details'),
                  );
                }),
          );
        });
  }

  bool validateURL(List<String> urls) {
    Pattern pattern = r'^(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+$';
    RegExp regex = new RegExp(pattern);

    for (var url in urls) {
      if (!regex.hasMatch(url)) {
        return false;
      }
    }
    return true;
  }

  void getButton(String url) {
    if (validateURL([url])) {
      setState(() {
        _isDisabled = false;
      });
    } else {
      setState(() {
        _isDisabled = true;
      });
    }
  }

setErrorMessage({String message, int t}){
    setState(() {
      errorMessage = message;
    t =type;
    });
  }
}