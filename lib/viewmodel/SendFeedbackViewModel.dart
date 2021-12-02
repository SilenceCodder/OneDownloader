import 'package:onedownloader/locator.dart';
import 'package:onedownloader/model/SendFeedbackModel.dart';
import 'package:onedownloader/service/FirestoreService.dart';
import 'package:stacked/stacked.dart';

class SendFeedbackViewModel extends BaseViewModel{
  String _message; //for displaying Error message or other Good message
  String get displayMessage => _message;
  int _messageType; //For displaying error message type 1 = Red, 2 => Green
   int get displayMessageType => _messageType;
     final FirestoreService _firestoreService = locator<FirestoreService>();


 sendData({String id, String body, String email, String subject, String title})async{
showMessage(msg: null);
   if(body.isEmpty || email.isEmpty || subject.isEmpty || title.isEmpty){
      showMessage(msg: 'All field must be fill', type: 0);
   }else{
       setBusy(true);

 try{
     var result =  await _firestoreService.sendFeedBack(SendFeedBackModel(
          id: id,
          body: body,
          email: email,
          subject: subject,
          title: title
          ));

          if(result is String){
             setBusy(false);
            showMessage(msg: 'Could not send Feedback', type: 0);
          }else{
              setBusy(false);
               showMessage(msg: 'Successfully send. Thanks for your message.', type: 1);
           
          }
            setBusy(false);

 }catch(e){
   showMessage(msg: e.toString(), type: 0);
    setBusy(false);
 }

   }
  
 }

 //FOr displaying Message
showMessage({String msg, int type}){
  _message = msg;
  _messageType = type;
  notifyListeners();
}
}