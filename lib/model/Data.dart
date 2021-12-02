import 'package:onedownloader/model/CategoryModel.dart';
import 'package:onedownloader/model/SliderModel.dart';
import 'package:onedownloader/model/LocalAdvert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onedownloader/Styles/AppColor.dart';
import 'package:onedownloader/Styles/AppImage.dart';

List<SliderModel> getSliderImage() {
  List<SliderModel> getslider = [
   // SliderModel(image: AppImage.board2),
    SliderModel(image: AppImage.ads),
   SliderModel(image: AppImage.board4),
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
        image: AppImage.tiktok,
        name: 'TicTok',
        isImage: true,
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
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.pinterest,),
    CategoryModel(
        image: AppImage.svg1,
        name: 'LinkedIn',
           color: Colors.white,
        iconColor: Colors.blue,
        icon: FontAwesomeIcons.linkedinIn),
    CategoryModel(
        image: AppImage.likee,
        isImage: true,
        name: 'Likee',
        color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.lowVision,),
        
    
  ];
  return getCategory2;
}


List<CategoryModel> getCategoryList3() {
  List<CategoryModel> getCategory3 = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Share App',
         color: Colors.white,
        iconColor: Colors.blue,
        icon: Icons.share),

        CategoryModel(
        image: AppImage.svg1,
        name: 'Feedback',
         color: Colors.white,
        iconColor: Colors.green,
        icon: FontAwesomeIcons.replyAll),

   CategoryModel(
        image: AppImage.svg1,
        name: 'Update App',
         color: Colors.white,
        iconColor: Colors.tealAccent,
        icon: FontAwesomeIcons.googlePlay),

        CategoryModel(
        image: AppImage.svg1,
        name: 'About Developer',
         color: Colors.white,
        iconColor: Colors.red,
        icon: FontAwesomeIcons.dev),
  ];
  return getCategory3;
}

List<LocalAdvert> getLocalAdvertList() {
  List<LocalAdvert>  getLocalAdvert = [
    LocalAdvert(
      id: "1",
      image:AppImage.hire,
      location: "https://wa.me/+2348185951999?text=Hi,%20Am%20%20messaging%20you%20from%20Nairaland%20App%20I%20need%20a%20Mobile%20Application%20Thanks",
      name: "Hire Mobile Developer",
      rate: "4"
    ),
    LocalAdvert(
      id: "1",
      image: AppImage.social1,
      location: "",
      name: "OneDowloader",
      rate: "4"
    ),
    LocalAdvert(
      id: "1",
      image: AppImage.social2,
      location: "",
      name: "OneDowloader",
      rate: "4"
    ),
   
  ];
  return getLocalAdvert;
}
