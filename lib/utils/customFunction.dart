import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/screen/AboutDeveloper.dart';
import 'package:onedownloader/screen/Facebook/FacebookHelp.dart';
import 'package:onedownloader/screen/TitTok/TikTokHelp.dart';
import 'package:onedownloader/screen/instagram/InstagramHelp.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppTextStyle.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//******** FOR DEVELOPER LOGICAL FUNCTION CREATED HIMSELF, */
class CustomFunction {
  
  launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  saveAdvertType({String advertStatus, String banner, String interstitial})async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString(advertType, advertStatus);
   prefs.setString(firebaseAdsBANNER, banner);
   prefs.setString(firebaseAdsINTERSTITIAL, interstitial);
  }


toastMessage({String message}){
  return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.rimary,
        textColor: Colors.white,
        fontSize: 16.0
    );
}

shareData({String value}){
  Share.share(value);
}


double screenHeightSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / 650.0;
}

double screenWidthSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width / 400.0;
}

Widget screenAppBar({String screenName, BuildContext context,String tab1name, String tab2name, int value}) {
  return AppBar(
                backgroundColor: Colors.white,
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
                      child: Icon(FontAwesomeIcons.question, size: 30, color:  Colors.red,),
                    ),
                    onTap: (){
                      if(value == 1){
                         Navigator.push(context, MaterialPageRoute(
                builder: (context) => FacebookHelp(),));
                
                      }else if(value  == 2){
                        //Instrgram
                         Navigator.push(context, MaterialPageRoute(
                builder: (context) => InstagramHelp(),));

                      }else if(value == 3){
                        //TikTok
                         Navigator.push(context, MaterialPageRoute(
                builder: (context) => TikTokHelp(),));

                      }
              //_navigationService.navigateTo(settingRoute);
              
                    },
                  )
                ],
                title:  Text(screenName, 
                style:  TextStyle(
              color: AppColor.rimary,
              fontSize: AppFontSizes.large,
              fontWeight: FontWeight.bold
            )
          ),
                bottom: TabBar(
                    unselectedLabelColor: AppColor.primaryDark,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.rimary,
                    indicatorWeight: 1.0,
                    indicator: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColor.primaryLight, AppColor.primaryLight]),
                        borderRadius: BorderRadius.circular(1),
                        color: AppColor.assents),
                        indicatorColor: AppColor.primaryDark,
                    tabs: [
                      Container(
                        height: 30,
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(tab1name, style: TextStyle(fontSize: 13),),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(tab2name,  style: TextStyle(fontSize: 13),),
                          ),
                        ),
                      ),
                    ]),
              );
}


errorUimessage({String errorMessage, int type, BuildContext context}){
   return  (errorMessage == null ? SizedBox.shrink() : Center(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         (type == 1 ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.error, color: Colors.red,)),
         SizedBox(width: 10,),
         Expanded(child: Text(errorMessage,
        textAlign: TextAlign.justify,
     overflow: TextOverflow.ellipsis,
         maxLines: 5,
           style: AppTextStyle.sellheader(context, (type == 1 ? Colors.green : Colors.red),)
           ),)
         

       ],),
   ));
  }

  loader(){
    return SpinKitSquareCircle(color: AppColor.rimary, duration: new Duration(seconds: 1), );
  }
shareApp()async{
    Share.share('Hi, Download your social media video, photos and audio with one Click. just copy your link and paste it on this App. Download the App now $playstoreLink');
  }
}
