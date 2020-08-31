import 'package:flutter/material.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppTextStyle.dart';
import 'package:onedownloader/widget/UpdateAppDialog.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Update',
          style: AppTextStyle.inputTextIncrease(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //UPDATE DIALOG
  updateDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return UpdateAppDialog(

              color: AppColor.rimary,
              title: 'Update',
              buttonText: 'OK',
              subtitile:
                  'A new version is available, update the app to enjoy more features');
        });
  }
}
