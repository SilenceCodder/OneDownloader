import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/screen/TitTok/tiktokData.dart';
import 'package:onedownloader/styles/AppImage.dart';
import 'package:onedownloader/styles/AppText.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/widget/MyButton.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class DownloadTab extends StatefulWidget {
 final Directory dir, thumbDir;
 const DownloadTab({this.dir, this.thumbDir});

  @override
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {
   final CustomFunction _customFunction = locator<CustomFunction>();
   String errorMessage;
   int type;
  var _ttScaffoldKey = GlobalKey<ScaffoldState>();
   TextEditingController _urlController = TextEditingController();
  TiktokProfile _ttProfile;
  bool _isDisabled = true, _showData = false, _notfirst = false, _isPrivate = false;
  bool _isPasted = true; 

  bool validateURL(List<String> urls) {
    Pattern pattern = r'^(http(s)?:\/\/)?((w){3}.)?tiktok?(\.com)?\/.+/video\/.+$';
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
                                      hintText: 'https://www.tiktok.com/...',
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
                         
                          //*** PASTE*/
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
             
             
              SizedBox(
                height: 10,
              ),
               //** BUTTON TO FETCH VIDEO */
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
                            _ttProfile = await TiktokData.postFromUrl('${_urlController.text}');
                            if (_ttProfile == null) {
                                setErrorMessage(message: "Sorry Unable to Connect", t: 0);

                              setState(() {
                                _notfirst = false;
                              });
                              return;
                            }
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
             
             
              _isPrivate
                  ? Text(
                      'This Account is Private',
                      style: TextStyle(fontSize: 14.0),
                    )
                  : Container(),

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
                                String _postDescription = '';

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
                                            thumbnail: NetworkImage(_ttProfile.videoData.thumbnailUrl),
                                            image: NetworkImage(_ttProfile.videoData.thumbnailUrl),
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
                                          _ttProfile.videoData.description,
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        onTap: () async {
                                          Clipboard.setData(ClipboardData(text: _postDescription));
                                          _customFunction.toastMessage(message: "Caption Copied");
                                        },
                                      ),
                                    ),

                                    //****FINAL DOWNLOAD */
                                    GestureDetector(
                      onTap: () async{
                        _customFunction.toastMessage(message: "Now Downloading....");
                                          String downloadUrl = _ttProfile.videoData.videoWatermarkUrl;
                                          String name = 'TT-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}.mp4';

                                          String thumbUrl = _ttProfile.videoData.thumbnailUrl;
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
                      : _customFunction.loader() //borderWidth: 5.0,
                  : Container(),
            ],
          ),
        ),
    );
  }
  setErrorMessage({String message, int t}){
    setState(() {
      errorMessage = message;
     type = t;
    });
  }
}