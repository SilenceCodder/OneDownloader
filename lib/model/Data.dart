import 'package:onedownloader/model/CategoryModel.dart';
import 'package:onedownloader/model/SliderModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppImage.dart';

List<SliderModel> getSliderImage() {
  List<SliderModel> getslider = [
    SliderModel(image: AppImage.board2),
    SliderModel(image: AppImage.ads),
    SliderModel(image: AppImage.board3),
  ];
  return getslider;
}

List<CategoryModel> getCategoryList() {
  List<CategoryModel> getCategory = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Facebook',
        color: Colors.white,
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.facebook),
    CategoryModel(
        image: AppImage.svg1,
        name: 'WhatsApp Status',
        color: Colors.white,
        iconColor: Colors.green,
        icon: FontAwesomeIcons.whatsapp),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Instagram',
         color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.instagram),
        CategoryModel(
        image: AppImage.svg1,
        name: 'TicTok',
         color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.instagram),
         CategoryModel(
        image: AppImage.svg1,
        name: 'Twitter',
         color: Colors.white,
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.twitter),
  ];
  return getCategory;
}

List<CategoryModel> getCategoryList2() {
  List<CategoryModel> getCategory2 = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Twitter',
         color: Colors.white,
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.twitter),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Pinterest',
        color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.pinterest,),
    CategoryModel(
        image: AppImage.svg1,
        name: 'LinkedIn',
         color: Colors.white,
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.linkedin),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Likee',
        color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.lowVision,),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Show more',
         color: Colors.white,
        iconColor: Colors.red,
        icon: Icons.more),
  ];
  return getCategory2;
}

List<CategoryModel> getCategoryList3() {
  List<CategoryModel> getCategory3 = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Bulk SMS',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/sms',
        icon: Icons.message),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Cable TV',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/cabletv',
        icon: FontAwesomeIcons.tv),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Electricity Bill',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/electricity',
        icon: FontAwesomeIcons.lightbulb),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Education',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/education',
        icon: FontAwesomeIcons.graduationCap),
  ];
  return getCategory3;
}

List<CategoryModel> getCategoryList4() {
  List<CategoryModel> getCategory3 = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Call',
        color: AppColor.rimary,
        webUrl: 'tel:+2347063188981',
        icon: Icons.message),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Whatsapp',
        color: AppColor.rimary,
        webUrl:
            'whatsapp://send?phone=2347063188981&text=Hi,+I+need+your+help+with',
        icon: FontAwesomeIcons.tv),
  ];
  return getCategory3;
}
