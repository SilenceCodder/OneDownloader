import 'package:onedownloader/Styles/AppColor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

//******** FOR DEVELOPER LOGICAL FUNCTION CREATED HIMSELF, */
class CustomFunction {
  launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
