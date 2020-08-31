import 'package:flutter/material.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/Screen/SplashScreen.dart';
import 'package:onedownloader/screen/Ads/FullAdsScreen.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';

import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //Onboard Screen Routing.
    case splashscreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SplashScreen(),
      );

//Dashboard
case dashboardRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DashboardScreen(),
      );
      
      case fullAdsRoute:
      var nextScreen = settings.arguments as Widget;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FullAdsScreen(pageTogo: nextScreen,),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

//***** ROUTE TYPE */

//Page Route without transition
PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

//Page Route with Transition
PageRoute _getPageRouteTransition(
    {Widget viewToShow, PageTransitionType pageTransitionType}) {
  return PageTransition(
    child: viewToShow,
    type: pageTransitionType,
    duration: Duration(seconds: 1),
  );
}
