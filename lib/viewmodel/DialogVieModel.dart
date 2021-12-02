import 'package:onedownloader/utils/customFunction.dart';
import 'package:stacked/stacked.dart';

class DialogVieModel extends BaseViewModel {
  final CustomFunction _developerFunction = new CustomFunction();

  updateApp() {
    String url =
        'https://play.google.com/store/apps/details?id=com.skite.onedownloader';
    _developerFunction.launchURL(url);
  }
}
