import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {

  bool _busy = false;
  bool get busy => _busy;

  
  bool _busy2 = false;
  bool get busy2 => _busy2;

  bool _busy3 = false;
  bool get busy3 => _busy3;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }


  void setBusy2(bool value) {
    _busy2 = value;
    notifyListeners();
  }

  void setBusy3(bool value) {
    _busy3 = value;
    notifyListeners();
  }

}
