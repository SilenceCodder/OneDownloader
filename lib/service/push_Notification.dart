import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/utils/customFunction.dart';

class PushNotification{
  final FirebaseMessaging _fcm = FirebaseMessaging();
  //NavigationService _navigationService = locator<NavigationService>();
  final CustomFunction _customFunction = locator<CustomFunction>();

  Future initialise()async{
   // print('>>>>>>>>> Notification Initialized >>>>>>>>>');
    
    if(Platform.isIOS){
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message)async{
        print('OnMessage: $message');
          serialNavigation(message: message);
      },
      onLaunch: (Map<String, dynamic> message)async{
        print('********onLaunch: $message');
        serialNavigation(message: message);
      },
      onResume: (Map<String, dynamic> message)async{
         print('********onResume: $message');
        serialNavigation(message: message);
      }
    );
  }

  void serialNavigation({Map<String, dynamic> message}){
    var notificationData = message['data'];
    var view = notificationData['view'];
    print('Data =>> $notificationData View ==>>$view');

      if(view != null){
       _customFunction.launchURL(view);
          //  _navigationService.navigateTo(pushNotificationRoute);
        
      }else{
          //_navigationService.navigateTo(pushNotificationRoute);
        //  _customFunction.launchURL(view);
      }

  }

  
  }
