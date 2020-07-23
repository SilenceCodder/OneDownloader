import 'package:flutter/material.dart';
import 'package:onedownloader/Screen/DashboardScreen.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/Screen/SplashScreen.dart';
import 'package:onedownloader/Service/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '1Downloader',
        navigatorKey: locator<NavigationService>().navigationKey,
        home: SplashScreen());
  }
}