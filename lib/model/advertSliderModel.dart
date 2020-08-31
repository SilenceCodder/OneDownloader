import 'package:flutter/foundation.dart';

class AdvertSliderModel with ChangeNotifier{
 bool status;
  String msg;
  List<Shops> shops;

  AdvertSliderModel({this.status, this.msg, this.shops});

  AdvertSliderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['shops'] != null) {
      shops = new List<Shops>();
      json['shops'].forEach((v) {
        shops.add(new Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  String id;
  String name;
  String rate;
  String location;
  String image;

  Shops({this.id, this.name, this.rate, this.location, this.image});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    location = json['location'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['location'] = this.location;
    data['image'] = this.image;
    return data;
  }
}