import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/instagram/InstagramData.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:progressive_image/progressive_image.dart';

class InstaDownloder extends StatefulWidget {
    final Directory dir, thumbDir;
 const InstaDownloder({this.dir, this.thumbDir});

  @override
  _InstaDownloderState createState() => _InstaDownloderState();
}

class _InstaDownloderState extends State<InstaDownloder> {
    var _igScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _urlController = TextEditingController();
  InstaProfile _instaProfile;
  InstaPost _instaPost = InstaPost();
  List<bool> _isVideo = [false];
  bool _showData = false, _isDisabled = true, _isPost = false, _isPrivate = false, _notfirst = false;
  final CustomFunction _customFunction = locator<CustomFunction>();
  bool _isPasted = true;
  String errorMessage;
   int type;

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
                                      hintText: 'https://www.instagram.com/...',
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
                    result['text'] = result['text'].toString().replaceAll(RegExp(r'\?igshid=.*'), '');
                    result['text'] = result['text'].toString().replaceAll(RegExp(r'https://instagram.com/'), '');
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _urlController.text = result['text'].toString().replaceAll(RegExp(r'\?igshid=.*'), ''),
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
                         //Check Internet Connection
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult == ConnectivityResult.none) {
                             setErrorMessage(message: "No Internet", t: 0);
                            return;
                          }

                          
                           setErrorMessage(message: "Fetching Download links...", t: 1);
                          setState(() {
                            _notfirst = true;
                            _showData = false;
                            _isPrivate = false;
                          });

                          if (_urlController.text.contains('/p/') || _urlController.text.contains('/tv/') || _urlController.text.contains('/reel/')) {
                            _instaProfile = await InstaData.postFromUrl('${_urlController.text}');
                            if (_instaProfile == null) {
                               setErrorMessage(message: "Invalid Url", t: 0);
                              setState(() {
                                _notfirst = false;
                              });
                            } else {
                              _instaPost = _instaProfile.postData;
                              if (_instaProfile.isPrivate == true) {
                                setState(() {
                                  _isPrivate = true;
                                });
                                _instaPost.childPostsCount = 1;
                                _instaPost.videoUrl = 'null';
                                _instaPost.photoSmallUrl = _instaProfile.profilePicUrl;
                                _instaPost.photoMediumUrl = _instaProfile.profilePicUrl;
                                _instaPost.photoLargeUrl = _instaProfile.profilePicUrlHd;
                                _instaPost.description = _instaProfile.bio;
                              } else {
                                setState(() {
                                  _isPrivate = false;
                                });
                              }

                              setState(() {
                                if (_instaPost.childPostsCount > 1) {
                                  _isVideo.clear();
                                  _instaPost.childposts.forEach((element) {
                                    element.videoUrl.length > 4 ? _isVideo.add(true) : _isVideo.add(false);
                                  });
                                } else {
                                  _isVideo.clear();
                                  _instaPost.videoUrl.length > 4 ? _isVideo.add(true) : _isVideo.add(false);
                                }
                                _showData = true;
                                _isPost = true;
                              });
                            }
                          } else {
                            // STORY
                            _instaProfile = await InstaData.storyFromUrl('${_urlController.text}');
                            if (_instaProfile == null) {
                               setErrorMessage(message: "Invalid Url", t: 0);
                              
                              setState(() {
                                _notfirst = false;
                              });
                            } else {
                              if (_instaProfile.isPrivate == true) {
                                setState(() {
                                  _isPost = true;
                                  _isPrivate = true;
                                });
                                _instaPost.childPostsCount = 1;
                                _instaPost.videoUrl = 'null';
                                _instaPost.photoSmallUrl = _instaProfile.profilePicUrl;
                                _instaPost.photoMediumUrl = _instaProfile.profilePicUrl;
                                _instaPost.photoLargeUrl = _instaProfile.profilePicUrlHd;
                                _instaPost.description = _instaProfile.bio;
                              } else {
                                setState(() {
                                  _isPost = false;
                                  _isPrivate = false;
                                  if (_instaProfile.storyCount > 0) {
                                    _isVideo.clear();
                                    for (var item in _instaProfile.storyData) {
                                      if (item.storyThumbnail == item.downloadUrl) {
                                        _isVideo.add(false);
                                      } else {
                                        _isVideo.add(true);
                                      }
                                    }
                                  }
                                });
                              }

                              setState(() {
                                _showData = true;
                              });
                            }
                          }
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
            _isPrivate
                ? Text(
                    'This Account is Private',
                    style: TextStyle(fontSize: 14.0),
                  )
                : Container(),
            _notfirst
                ? _showData
                    ? _isPost
                        ? Container(
                            padding: EdgeInsets.only(bottom: 30.0),
                            margin: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: _customFunction.screenHeightSize(350, context),
                              child: GridView.builder(
                                itemCount: _instaPost.childPostsCount,
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
                                              thumbnail: NetworkImage(_instaPost.childPostsCount > 1 ? _instaPost.childposts[index].photoMediumUrl : _instaPost.photoMediumUrl),
                                              image: NetworkImage(_instaPost.childPostsCount > 1 ? _instaPost.childposts[index].photoLargeUrl : _instaPost.photoLargeUrl),
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          _isVideo[index]
                                              ? Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Icon(Icons.videocam),
                                                  ),
                                                )
                                              : Align(),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0, left: 5.0),
                                        child: GestureDetector(
                                          child: Text(
                                            '${_instaPost.description.length > 100 ? _instaPost.description.replaceRange(100, _instaPost.description.length, '') : _instaPost.description}...',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          onTap: () async {
                                            Clipboard.setData(ClipboardData(text: _instaPost.description));
                                             _customFunction.toastMessage(message: "Caption Copied");
                                          },
                                        ),
                                      ),
                                         //****FINAL DOWNLOAD */
                                    GestureDetector(
                      onTap: () async{
                       _customFunction.toastMessage(message: "Added to Download");
                                            String downloadUrl = _instaPost.childPostsCount == 1 ? _instaPost.videoUrl.length > 4 ? _instaPost.videoUrl : _instaPost.photoLargeUrl : _instaPost.childposts[index].videoUrl.length > 4 ? _instaPost.childposts[index].videoUrl : _instaPost.childposts[index].photoLargeUrl;
                                            String name = 'IG-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}.${downloadUrl.toString().contains('jpg') ? 'jpg' : 'mp4'}';
                                            String thumbUrl = _instaPost.childPostsCount > 1 ? _instaPost.childposts[index].photoLargeUrl : _instaPost.photoLargeUrl;
                                            await FlutterDownloader.enqueue(
                                              url: thumbUrl,
                                              savedDir: widget.thumbDir.path,
                                              fileName: name.substring(0, name.length - 3) + 'jpg',
                                              showNotification: false,
                                            );
                                            await FlutterDownloader.enqueue(
                                              url: downloadUrl,
                                              savedDir: widget.dir.path,
                                              fileName: name,
                                              showNotification: true,
                                              openFileFromNotification: true,
                                            );
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
                            "Process to Download",
                            style: AppTextStyle.header4(context, Colors.white)
                          ),
                        ),
                      ),
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
                            padding: EdgeInsets.only(bottom: 30.0),
                            margin: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height:_customFunction.screenHeightSize(280, context),
                              child: GridView.builder(
                                itemCount: _instaProfile.storyCount,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            height: _customFunction.screenWidthSize(165, context),
                                            width: _customFunction.screenWidthSize(125, context),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                            child: ProgressiveImage(
                                              placeholder: AssetImage(AppImage.imageloadingGif),
                                              thumbnail: NetworkImage(_instaProfile.storyData[index].storyThumbnail),
                                              image: NetworkImage(_instaProfile.storyData[index].storyThumbnail),
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          _isVideo[index]
                                              ? Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Icon(Icons.videocam),
                                                  ),
                                                )
                                              : Align(),
                                        ],
                                      ),
                                         //****FINAL DOWNLOAD */
                                    GestureDetector(
                      onTap: () async{
                       _customFunction.toastMessage(message: "Added to Download");
                     String downloadUrl = _instaProfile.storyData[index].downloadUrl;
                                            String name = 'IG-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}.${downloadUrl.toString().contains('jpg') ? 'jpg' : 'mp4'}';
                                            String thumbUrl = _instaProfile.storyData[index].storyThumbnail;
                                            _isVideo[index] == true
                                                ? await FlutterDownloader.enqueue(
                                                    url: thumbUrl,
                                                    savedDir: widget.thumbDir.path,
                                                    fileName: name.substring(0, name.length - 3) + 'jpg',
                                                    showNotification: false,
                                                  )
                                                : print('');
                                            await FlutterDownloader.enqueue(
                                              url: downloadUrl,
                                              savedDir: widget.dir.path,
                                              fileName: name,
                                              showNotification: true,
                                              openFileFromNotification: true,
                                            );
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
                            style: AppTextStyle.header4(context, Colors.white)
                          ),
                        ),
                      ),
                    ),
                                    ],
                                  );
                                },
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 0.5,
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

   bool validateURL(List<String> urls) {
    Pattern pattern = r'^((http(s)?:\/\/)?((w){3}.)?instagram?(\.com)?\/|).+$';
  
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