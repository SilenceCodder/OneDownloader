import 'package:onedownloader/viewmodel/base_model.dart';

class FeaturedViewModel extends BaseModel {
  String url;

  initalize() {
    setBusy(true);
    url = 'https://www.nairaland.com/news';
//notifyListeners();
    setBusy(false);
  }
}
