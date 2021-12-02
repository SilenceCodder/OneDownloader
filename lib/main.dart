import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:onedownloader/constants.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/Service/navigation_service.dart';
import 'package:onedownloader/screen/Ads/FullAdsScreen.dart';
import 'package:onedownloader/screen/DashboardScreen.dart';
import 'package:onedownloader/screen/SplashScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:onedownloader/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await FlutterDownloader.initialize(debug: true 
  // optional: set false to disable printing logs to console
      );
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
       SharedPreferences prefs = await SharedPreferences.getInstance();
        var board = prefs.getString(onboard);

    if(board == null){  
    runApp(App(data: null,));
    }else{
    runApp(App(data: "0",));
    }
    

}


class App extends StatefulWidget {
  final String data;
  App({this.data});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

    @override
  void initState() {
    super.initState();
    sendUssdRequest();
  }
  
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OneDownloader',
        navigatorKey: locator<NavigationService>().navigationKey,
        home: (widget.data == null ?  SplashScreen() : FullAdsScreen(pageTogo: DashboardScreen(),)),
        onGenerateRoute: generateRoute,
        );//SplashScreen());//FullAdsScreen(pageTogo: dashboardRoute,)); //DashboardScreen());
  }


  Future<void> sendUssdRequest() async {
     var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
  }
 }
}

// ///******* REQUEST PERMISTION */
// class MyApp extends StatefulWidget {
//   @override 
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _storagePermissionCheck;
//   Future<int> _storagePermissionChecker;

//   @override
//   void initState() {
//     super.initState();
//     _storagePermissionChecker = (() async {
//       int storagePermissionCheckInt;
//       int finalPermission;

//       print("Initial Values of $_storagePermissionCheck");
//       if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
//         _storagePermissionCheck = await checkStoragePermission();
//       } else {
//         _storagePermissionCheck = 1;
//       }
//       if (_storagePermissionCheck == 1) {
//         storagePermissionCheckInt = 1;
//       } else {
//         storagePermissionCheckInt = 0;
//       }

//       if (storagePermissionCheckInt == 1) {
//         finalPermission = 1;
//       } else {
//         finalPermission = 0;
//       }

//       return finalPermission;
//     })();
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveTheme(
//         light: ThemeData(brightness: Brightness.light, primarySwatch: Colors.teal),
//         initial: AdaptiveThemeMode.light,
//         dark: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
//         builder: (theme, darkTheme) => MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'OneDownloader',
//             theme: theme,
//             darkTheme: darkTheme,
//             home: DefaultTabController(
//                 length: 2,
//                 child: FutureBuilder(
//                     future: _storagePermissionChecker,
//                     builder: (context, status) {
//                       if (status.connectionState == ConnectionState.done) {
//                         if (status.hasData) {
//                           print(status.data);
//                           if (status.data == 1) {
//                             return Splash();
//                           } else {
//                             return Scaffold(
//                                 body: Container(
//                                     decoration: BoxDecoration(
//                                         gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
//                                       Colors.lightBlue[100],
//                                       Colors.lightBlue[200],
//                                       Colors.lightBlue[300],
//                                       Colors.lightBlue[200],
//                                       Colors.lightBlue[100]
//                                     ])),
//                                     child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                               padding: EdgeInsets.all(20.0),
//                                               child: Text("Storage Permission Required", style: TextStyle(fontSize: 20.0))),
//                                           FlatButton(
//                                               padding: EdgeInsets.all(15.0),
//                                               child: Text("Allow Storage Permission", style: TextStyle(fontSize: 20.0)),
//                                               color: Colors.indigo,
//                                               textColor: Colors.white,
//                                               onPressed: () {
//                                                 setState(() {
//                                                   _storagePermissionChecker = requestStoragePermission();
//                                                 });
//                                               })
//                                         ])));
//                           }
//                         } else {
//                           return Scaffold(
//                               body: Container(
//                                   decoration: BoxDecoration(
//                                       gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
//                                     Colors.lightBlue[100],
//                                     Colors.lightBlue[200],
//                                     Colors.lightBlue[300],
//                                     Colors.lightBlue[200],
//                                     Colors.lightBlue[100]
//                                   ])),
//                                   child: Center(
//                                       child: Text("Something went wrong.. Please uninstall and Install Again.",
//                                           style: TextStyle(fontSize: 20.0)))));
//                         }
//                       } else {
//                         return Scaffold(body: Container(child: Center(child: CircularProgressIndicator())));
//                       }
//                     }))));
//   }

//   Future<int> checkStoragePermission() async {
//     PermissionStatus result = await Permission.storage.status;
//     setState(() {
//       _storagePermissionCheck = 1;
//     });

//     if (result.isDenied) {
//       return 0;
//     } else if (result.isGranted) {
//       return 1;
//     } else
//       return 0;
//   }

//   Future<int> requestStoragePermission() async {
//     Map<Permission, PermissionStatus> result = await [Permission.storage].request();

//     if (result[Permission.storage].isDenied) {
//       return 1;
//     } else if (result[Permission.storage].isGranted) {
//       return 2;
//     } else {
//       return 1;
//     }
//   }
// }
