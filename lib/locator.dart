import 'package:get_it/get_it.dart';
import 'package:onedownloader/Service/navigation_service.dart';
import 'package:onedownloader/service/DynamicLinkService.dart';
import 'package:onedownloader/service/push_Notification.dart';
import 'package:onedownloader/utils/customFunction.dart';

//Instead of creating instance of an Object, Multiple times
//Dependency inject solvpe it by creating this code.

GetIt locator = GetIt.instance;

//Register class for Dep. Injection.
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => CustomFunction());
  locator.registerLazySingleton(() => PushNotification());
locator.registerLazySingleton(() => DynamicLinkService());
}
