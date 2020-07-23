

import 'package:flutter/foundation.dart';

class SaveModel with ChangeNotifier{
  int _id;
  String _picname;
  String _prjname;

  SaveModel.without();

  SaveModel(this._picname, this._prjname); // Convert a BotModel object into a Map object

  SaveModel.withId(this._id, this._picname, this._prjname);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get picname => _picname;

  String get prjname => _prjname;

  set prjname(String value) {
    _prjname = value;
  }

  set picname(String value) {
    _picname = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['picname'] = _picname;
    map['prjname'] = _prjname;
    return map;
  }

  SaveModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._picname = map['picname'];
    this._prjname = map['prjname'];
  }
  SaveModel.folders(Map<String, dynamic> map) {
    this._prjname = map['prjname'];
  }

  SaveModel.folderspicture(Map<String, dynamic> map) {
    this._picname = map['picname'];
  }

}