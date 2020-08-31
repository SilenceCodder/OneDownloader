
import 'package:stacked/stacked.dart';

class FeaturedViewModel extends BaseViewModel {
  String url;

  initalize() {
    setBusy(true);
    url = 'https://www.nairaland.com/news';
//notifyListeners();
    setBusy(false);
  }
}
