import 'package:flutter/material.dart';
//********** THIS FILE CONTAIN ALL COLOR USE THROUGOUT THE APP*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor {
  static const Color rimary = Color(0xFFBAB100); //Color(0xFF076308); 
  static const Color primaryDark = Color(0xFF012E07);
  static Color bg = Colors.yellow.shade50;
  static Color header = Color(0xFF5F5B00);
  static Color assents = Color(0xFF469131);
  static const Color primaryColor = const Color(0xFF6200EE);
  static const Color secondaryColor = const Color(0xFF3700B3);
  static const Color pageButtons = const Color(0xFF3700B3);
  static const Color boardPageColor = const Color(0xF6F6F7FF);
  static const Color secondaryLightColor = const Color(0xFFBB86FC);
  static const Color a1 = const Color(0xFFffab00);
  static const Color a2 = const Color(0xFFff6f00);
  static const Color a3 = const Color(0xFFbf360c);
}


abstract class BaseTheme {
  int themeID;
  Color primary;
  Color primary60;
  Color primary50;
  Color primary30;
  Color primary15;
  Color primary10;

  Color secondary;

  Color success;
  Color success30;
  Color success15;
  Color success10;

  Color danger;
  Color danger30;
  Color danger15;

  Color backgroundPrimary;
  Color backgroundPrimary60;
  Color backgroundPrimary30;
  Color backgroundPrimary15;
   Color darkprimaryOpacity;

  Color backgroundSecondary;
  Color shadow;
  Color shadow50;
  Color shadow10;

  Color textDark;
  Color textDark60;
  Color textDark10;
  Color textLight;
  Color textLight30;
  Color textLight15;
  Color switchKnob;
  Color switchTrack;

  LinearGradient gradientPrimary;
  LinearGradient gradientListTop;

  BoxShadow shadowPrimaryOne;
  BoxShadow shadowPrimaryTwo;

  String illustrationNewWallet;
  String illustrationBackup;
  String illustrationTwoOptions;
  String illustrationBorrowed;
  String illustrationSecurity;

  String animationWelcome;
  String animationSend;
  String animationNameChange;
  String animationSale;
  String animationTransfer;
  String animationGetAccount;
  String animationSearch;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;

  /// Operator overrides
  bool operator ==(o) => (o != null && o.hashCode == hashCode);
  int get hashCode => themeID.hashCode;
}

class AppColor2 extends BaseTheme {
  int themeID = 1;

  static const Color orange = Color(0xFFF7941F);
  static const Color rimary = Color(0xFFC988F4);
  static const primaryLightColor = const Color(0xFFEEEDED);
  static const Color lightrimary = Color(0xFFA66DF7);
    static const primaryColor = const Color(0xFF353434);
  static const primaryDarkColor = const Color(0xFFE2E1E1);
  static const primaryDarkColord = const Color(0xFF916dd5);
  static const Color darkrimary = Color(0xFF8151FA);
  static const Color p = Color(0xFF8151FA);
  static const Color deep = Color(0xFF6200ea);
  static const Color teal = Color(0xFF311b92);
  static const Color primaryLight = Color(0xFFb388ff);
  static const Color red = Color(0xFF7e57c2);
  static const Color accents = Color(0xFFb388ff);
  static const Color deep00 = Color(0x00FF7c4dff);
  static const Color colorDark = Color(0xFF7e57c2);
  static const Color black = Color(0xFF000000);
  static const Color noInternet = Color(0xFF69BDEE);
  Color darkprimaryOpacity = darkrimary.withOpacity(0.5);

  Color primary = orange;
  Color primary60 = orange.withOpacity(0.6);
  Color primary50 = orange.withOpacity(0.5);
  Color primary30 = orange.withOpacity(0.3);
  Color primary15 = orange.withOpacity(0.15);
  Color primary10 = orange.withOpacity(0.10);
 
  //Color secondary = yellow;
  Color success = teal;
  Color success30 = teal.withOpacity(0.3);
  Color success15 = teal.withOpacity(0.15);
  Color success10 = teal.withOpacity(0.1);
  Color successg = accents.withOpacity(0.15);
  Color danger = red;
  Color danger30 = red.withOpacity(0.3);
  Color danger15 = red.withOpacity(0.15);

  Color backgroundPrimary = accents;
  Color backgroundPrimary60 = accents.withOpacity(0.6);
  Color backgroundPrimary30 = accents.withOpacity(0.3);
  Color backgroundPrimary15 = accents.withOpacity(0.15);

  Color backgroundSecondary = accents;

  Color textDark = colorDark;
  Color textDark60 = colorDark.withOpacity(0.6);
  Color textDark50 = colorDark.withOpacity(0.5);
  Color textDark40 = colorDark.withOpacity(0.4);
  Color textDark30 = colorDark.withOpacity(0.3);
  Color textDark15 = colorDark.withOpacity(0.15);
  Color textDark10 = colorDark.withOpacity(0.1);

  Color shadow = colorDark;
  Color shadow50 = colorDark.withOpacity(0.5);
  Color shadow10 = colorDark.withOpacity(0.1);

  Color textLight = accents;
  Color textLight30 = accents.withOpacity(0.3);
  Color textLight15 = accents.withOpacity(0.15);

  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  Color switchKnob = accents;
  Color switchTrack = black.withOpacity(0.1);

//  LinearGradient gradientPrimary = LinearGradient(
//    begin: Alignment.bottomLeft,
//    end: Alignment.topRight,
//    stops: [0.0, 1],
//    colors: [orange, yellow],
//  );

  LinearGradient gradientListTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [accents, deep00],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: orange.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: orange.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessOne = BoxShadow(
      color: teal.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessTwo = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccess = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: colorDark.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDarkTwo = BoxShadow(
      color: colorDark.withOpacity(0.25),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: colorDark.withOpacity(0.2),
      offset: Offset(0, 10),
      blurRadius: 20,
      spreadRadius: -3.3);

  BoxShadow shadowAccountCard = BoxShadow(
      color: colorDark.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -2.6);

  BoxShadow shadowBottomBar = BoxShadow(
      color: colorDark.withOpacity(0.2),
      offset: Offset(0, -15),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowSettingsList = BoxShadow(
      color: colorDark.withOpacity(0.4),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowDangerOne = BoxShadow(
      color: red.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowDangerTwo = BoxShadow(
      color: red.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
}
