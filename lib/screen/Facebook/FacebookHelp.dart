import 'package:flutter/material.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppImage.dart';

class FacebookHelp extends StatefulWidget {
  @override
  _FacebookHelpState createState() => _FacebookHelpState();
}

class _FacebookHelpState extends State<FacebookHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.grey,),
                  onTap: (){
                     Navigator.pop(context);
                  },
                ),
                title:  Text('How to download', 
                style:  TextStyle(
              color: AppColor.rimary,
              fontSize: AppFontSizes.large,
              fontWeight: FontWeight.bold
            )
          ),
      ),
      body: Column(
        children: <Widget>[
           SizedBox(width: 10),
         Row(children: <Widget>[
            Icon(Icons.check), 
            SizedBox(width: 5),
            Expanded(
            child: Text('Open your facebook, Goto video page, click on menu, tap to copy link', 
                  style:  TextStyle(
                color: AppColor.rimary,
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.bold
              )
          ),
            ),
         ]),
          SizedBox(height: 10),
         
           Row(children: <Widget>[
            Icon(Icons.check), 
            SizedBox(width: 5),
            Expanded(
               child: Image.asset(AppImage.fbguide),
            ),
         ]),
          SizedBox(height: 10),
          Row(children: <Widget>[
            Icon(Icons.check), 
            SizedBox(width: 5),
            Expanded(
              child: Text('Open OneDownloader and paste the link', 
                  style:  TextStyle(
                color: AppColor.rimary,
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.bold
              )
          ),
            ),
         ]),
         

        ],
      )
    );
  }
}