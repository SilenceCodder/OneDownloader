import 'package:onedownloader/utils/customFunction.dart';
import 'package:onedownloader/viewmodel/base_model.dart';

class DialogVieModel extends BaseModel {
  final CustomFunction _developerFunction = new CustomFunction();

  updateApp() {
    String url =
        'https://play.google.com/store/apps/details?id=com.skitetech.nairaland';
    _developerFunction.launchURL(url);
  }
}
