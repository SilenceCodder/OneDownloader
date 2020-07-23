import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onedownloader/Styles/AppFontSizes.dart';

class AppTextStyle {
  static TextStyle header1(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.largest, textStyle: TextStyle(color: color));
  }

  static TextStyle header1Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.largest,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle header1BoldSmall(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle header2Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large2_1,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle header2(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.larger, textStyle: TextStyle(color: color));
  }

  static TextStyle header3(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large,
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(color: color));
  }

  static TextStyle header4(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large2, textStyle: TextStyle(color: color));
  }

  static TextStyle header4bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large2,
        textStyle: TextStyle(fontWeight: FontWeight.bold, color: color));
  }

  static TextStyle wallectB(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.large,
        textStyle: TextStyle(fontWeight: FontWeight.bold, color: color));
  }

  static TextStyle wallectBSmall(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.small,
        textStyle: TextStyle(fontWeight: FontWeight.bold, color: color));
  }

  static TextStyle sub(BuildContext context, Color color) {
    // return TextStyle(
    //       fontFamily: "Plak W01 Black Condensed",
    //       fontSize: AppFontSizes.large,
    // );
    return GoogleFonts.adamina(
        //aBeeZee
        fontSize: AppFontSizes.smallest,
        textStyle: TextStyle(
          color: color,
        ));
  }

  static TextStyle tabs(BuildContext context, Color color) {
    // return TextStyle(
    //       fontFamily: "Plak W01 Black Condensed",
    //       fontSize: AppFontSizes.large,
    // );
    return GoogleFonts.adamina(
        //aBeeZee
        fontSize: AppFontSizes.smallest,
        textStyle: TextStyle(
          color: color,
        ));
  }

  static TextStyle test(BuildContext context, Color color) {
    return TextStyle(
      fontFamily: "Lintel",
      fontSize: AppFontSizes.smallest,
      color: color,
    );
  }

  static TextStyle header4Bold(BuildContext context, Color color) {
    return GoogleFonts.quintessential(
        //aBeeZee
        fontSize: AppFontSizes.large2_1,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle header5(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.medium, textStyle: TextStyle(color: color));
  }

  static TextStyle sty(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.large, textStyle: TextStyle(color: color));
  }

  static TextStyle balace(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.largest,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle balaceLarge(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.large,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle subHeader1(BuildContext context, Color color) {
    return GoogleFonts.notoSans(
        fontSize: AppFontSizes.medium, textStyle: TextStyle(color: color));
  }

  static TextStyle inputText(BuildContext context) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.small,
        textStyle: TextStyle(color: Colors.black));
  }

  static TextStyle inputTextWColor(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.small, textStyle: TextStyle(color: color));
  }

  static TextStyle inputTextDecreaced(BuildContext context) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.smallest,
        textStyle: TextStyle(color: Colors.black));
  }

  static TextStyle inputTextIncrease(BuildContext context) {
    return GoogleFonts.aBeeZee(
        fontSize: AppFontSizes.large,
        textStyle: TextStyle(color: Colors.black));
  }

  static TextStyle subHeader2(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.small, textStyle: TextStyle(color: color));
  }

  static TextStyle sellheader(BuildContext context, Color color) {
    return GoogleFonts.spinnaker(
        fontSize: AppFontSizes.smallest, textStyle: TextStyle(color: color));
  }

  static TextStyle subheader3(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.smallest, textStyle: TextStyle(color: color));
  }

  static TextStyle lHeader(BuildContext context, Color color) {
    return TextStyle(
        fontFamily: "Helvetica",
        fontSize: AppFontSizes.large2_1,
        fontWeight: FontWeight.bold);
  }

  static TextStyle subheader3Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
        fontSize: AppFontSizes.smallest,
        textStyle: TextStyle(fontWeight: FontWeight.bold, color: color));
  }

  static TextStyle h(BuildContext context, Color color) {
    return GoogleFonts.quintessential(
        //aBeeZee
        fontSize: AppFontSizes.large2,
        textStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  static TextStyle copBold(BuildContext context, Color color) {
    return TextStyle(
        fontFamily: "Corporate Rounded Bold Oblique",
        fontSize: AppFontSizes.large2_1,
        fontWeight: FontWeight.bold);
  }

  static TextStyle copRound(BuildContext context, Color color) {
    return TextStyle(
      fontFamily: "Corporate Rounded Oblique",
      fontSize: AppFontSizes.small,
    );
  }

  static TextStyle copRregular(BuildContext context, Color color) {
    return TextStyle(
        fontFamily: "Corporate Rounded Regular",
        fontSize: 24 //AppFontSizes.large2_1,
        );
  }

  static TextStyle spinkerR(BuildContext context, Color color) {
    return TextStyle(
        fontFamily: "Spinnaker-Regular",
        fontSize: AppFontSizes.large2_1,
        fontWeight: FontWeight.bold);
  }
}
