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
        name: 'Home',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com',
        icon: Icons.home),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Airtime',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/airtime',
        icon: FontAwesomeIcons.mobile),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Data',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/data_bundle',
        icon: FontAwesomeIcons.wifi),
    CategoryModel(
        image: AppImage.svg1,
        name: 'MTN CUG',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/cug',
        icon: Icons.new_releases),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Recharge card',
        webUrl: 'http://app.samicsub.com/user/recharge_cards',
        color: AppColor.rimary,
        icon: FontAwesomeIcons.lightbulb),
  ];
  return getCategory;
}

List<CategoryModel> getCategoryList2() {
  List<CategoryModel> getCategory2 = [
    CategoryModel(
        image: AppImage.svg1,
        name: 'Profile',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/profile',
        icon: FontAwesomeIcons.user),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Wallet',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/wallet',
        icon: FontAwesomeIcons.googleWallet),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Own a website',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/own-a-website',
        icon: FontAwesomeIcons.intercom),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Become Marketer',
        webUrl: 'http://app.samicsub.com/user/become-an-oline-marketer',
        color: AppColor.rimary,
        icon: FontAwesomeIcons.superpowers),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Upgrade Plan',
        webUrl: 'http://app.samicsub.com/user/upgrade-plan',
        color: AppColor.rimary,
        icon: Icons.trending_up),
    CategoryModel(
        image: AppImage.svg1,
        name: 'All Transaction',
        color: AppColor.rimary,
        webUrl: 'http://app.samicsub.com/user/all-transactions',
        icon: Icons.list),
    CategoryModel(
        image: AppImage.svg1,
        name: 'Price List',
        webUrl: 'http://app.samicsub.com/user/price-list',
        color: AppColor.rimary,
        icon: Icons.history),
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
