import 'dart:io';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/MyButton.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:onedownloader/screen/Facebook/FacebookData.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class DowloadFacebook extends StatefulWidget {
  final Directory dir, thumbDir;
 const DowloadFacebook({this.dir, this.thumbDir});

  @override
  _DowloadFacebookState createState() => _DowloadFacebookState();
}

class _DowloadFacebookState extends State<DowloadFacebook> {
  final CustomFunction _customFunction = locator<CustomFunction>();
  
    FacebookProfile _fbProfile;
  TextEditingController _urlController = TextEditingController();
  bool _isDisabled = true, _showData = false, _hasAudio = true, _notfirst = false;
  String _postThumbnail = '';
  var thumb;
  bool _isPasted = true;
   String errorMessage;
   int type;

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
                                      hintText: 'https://www.facebook.com/...',
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
                          _fbProfile = await FacebookData.postFromUrl('${_urlController.text}');
                          if (_fbProfile.postData.videoMp3Url == '') {
                            setState(() {
                              _hasAudio = false;
                            });
                          } else {
                            setState(() {
                              _hasAudio = true;
                            });
                          }
                          _postThumbnail = await _loadthumb(_fbProfile.postData.videoHdUrl.toString());

                          setState(() {
                            _showData = true;
                          });
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
            SizedBox(
              height: 10,
            ),
            _notfirst
                ? _showData
                    ? Container(
                        padding: EdgeInsets.only(bottom: 30.0),
                        margin: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: _customFunction.screenHeightSize(350, context),
                          child: GridView.builder(
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
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
                                          thumbnail: FileImage(File(_postThumbnail)),
                                          image: FileImage(File(_postThumbnail)),
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
                                                  _customFunction.toastMessage(message: "Now Downloading....");
                                                  String downloadUrl = _fbProfile.postData.videoSdUrl;
                                                  String name = 'FB-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}(Audio).mp3';

                                                  await FlutterDownloader.enqueue(
                                                    url: downloadUrl,
                                                    savedDir: widget.dir.path,
                                                    fileName: name,
                                                    showNotification: true,
                                                    openFileFromNotification: true,
                                                  );
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
                                            _customFunction.toastMessage(message: "Now Downloading....");
                                            String downloadUrl = _fbProfile.postData.videoHdUrl;
                                            String name = 'FB-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}.mp4';

                                            File thumbFile = File(_postThumbnail);
                                            String thumbname = name.substring(0, name.length - 3) + 'jpg';
                                            String newThumbName = '${widget.thumbDir.path}/$thumbname';

                                            await thumbFile.copy(newThumbName);

                                            await FlutterDownloader.enqueue(
                                              url: downloadUrl,
                                              savedDir: widget.dir.path,
                                              fileName: name,
                                              showNotification: true,
                                              openFileFromNotification: true,
                                            );
                                             setErrorMessage(message: "Downloading.. Check download status in Notification bar...", t: 1);
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
                    : _customFunction.loader()
                : Container(),
          ],
        ),
      ),
   
    );
  }

    Future<String> _loadthumb(String videoUrl) async {
    thumb = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: widget.thumbDir.path,
      imageFormat: ImageFormat.PNG,
    );
    var rep = thumb.toString().substring(thumb.toString().indexOf('ThumbFiles/') + 'ThumbFiles/'.length, thumb.toString().indexOf('.mp4'));
    File thumbname = File(thumb.toString());
    thumbname.rename(widget.thumbDir.path + '$rep.png');

    print(widget.thumbDir.path + '$rep.png');
    return (widget.thumbDir.path + '$rep.png');
  }

   bool validateURL(List<String> urls) {
    // Pattern pattern = r'^(http(s)?:\/\/)?((w){3}.)?facebook?(\.com)?\/(watch\/\?v=.+|.+\/videos\/.+)$';
    Pattern pattern = r'^(http(s)?:\/\/)?((w){3}.)?facebook?(\.com)?\/.+$';
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
     type = t;
    });
  }
}