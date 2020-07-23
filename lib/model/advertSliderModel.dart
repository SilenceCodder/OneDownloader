import 'package:flutter/foundation.dart';

class AdvertSliderModel with ChangeNotifier{
  String status;
  String message;
  List<Data> data;

  AdvertSliderModel({this.status, this.message, this.data});

  AdvertSliderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String vendorId;
  String name;
  String location;
  String image;
  String createdAt;

  Data(
      {this.id,
      this.vendorId,
      this.name,
      this.location,
      this.image,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
