import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/utils/customFunction.dart';

class DynamicLinkService {
  
final CustomFunction _customFunction = locator<CustomFunction>();

    Future handleDynamicLinks() async {
      print('Dynamic Link is here for initialize');
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    _handleDeepLink(data);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      print('***************************Have Retried the Data');
      _handleDeepLink(dynamicLink);

    }, onError: (OnLinkErrorException e) async {
      print('***************************Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    
  if (deepLink != null) {
    _customFunction.launchURL(deepLink.toString());

    // var navigationRoute = deepLink.queryParameters['route'];

    // var params = deepLink.queryParameters['params'];
    // print('queryParameters(route) : $navigationRoute');
    // print('queryParameters(Params): $params');

    // if (params != null) {
    //   //_navigationService.navigateTo(navigationRoute, arguments: params);
    //   //Navigating to splash Screen...
    // _navigationService.navigateTowithoutBack(splashRoute);
    // }
  }
  }
 
}