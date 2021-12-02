import 'package:flutter/material.dart';
import 'package:onedownloader/styles/AppColor.dart';
import 'package:onedownloader/styles/AppFontSizes.dart';
import 'package:onedownloader/styles/AppImage.dart';

class InstagramHelp extends StatefulWidget {
  @override
  _InstagramHelpState createState() => _InstagramHelpState();
}

class _InstagramHelpState extends State<InstagramHelp> {
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
               child: Image.asset(AppImage.instguide,)
            ),
         ]),
          SizedBox(height: 10),
          Row(children: <Widget>[
            Icon(Icons.check), 
            SizedBox(width: 10),
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