import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:onedownloader/core/Abstract/baseApi.dart';
import 'package:onedownloader/model/advertSliderModel.dart';
import 'package:onedownloader/Service/baseUrl.dart';

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class API implements BaseApi {
  Map<String, String> headers = new HashMap();
  static int httpDuration =
      10; //show data within 10, else display an exception.. Am setting it to 10 sec because THIS IS NIGERIA

  //***********API for fetching Slider Image at the Dashboard...
  @override
  Future<AdvertSliderModel> getAdvertImageData() async {
    // headers['Accept'] = 'application/json';
    // headers['Content-type'] = 'application/json';
    var map = new Map<String, String>();
    map['vendor_id'] = 'b56f167fbbeea57f17d577a70ee03d81468da2be';

    try {
      var response = await http
          .post(BaseUrl().adverts,
              //headers: headers,
              body: map)
          .timeout(Duration(seconds: httpDuration));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty) {
        AdvertSliderModel sliderModel = AdvertSliderModel.fromJson(convert);
        return sliderModel;
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
      //Exception if data load for 5 seconds and no response
      print('Timeout Execption');
      throw Failure('Connection Timeout, Please try again 😱');
    } on SocketException catch (_) {
      //Exception if there's no Internet
      throw Failure('No Internet connection 😑');
    } on HttpException {
      //Exception if there's invalid request
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      //Exception if there's invalid Http
      throw Failure("Bad response format 👎. Please Contact the Admin");
    }
  }
}
