import 'package:onedownloader/model/advertSliderModel.dart';

abstract class BaseApi {
  Future<AdvertSliderModel> getAdvertImageData();
}
