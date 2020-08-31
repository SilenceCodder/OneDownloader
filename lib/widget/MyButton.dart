import 'package:flutter/material.dart';

import 'package:onedownloader/styles/AppColor.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final EdgeInsets padding;

  MyButton({this.text, this.onPressed, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: (color != null) ? color :AppColor.primaryDark,
      disabledColor: AppColor.rimary,
      child: Padding(
        padding: (padding != null) ? padding : EdgeInsets.all(15.0),
        child: Text((text != null) ? text : "Button,", style: TextStyle(color: Colors.white,),),
      ),
      onPressed: onPressed,
    );
  }
}