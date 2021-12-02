
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onedownloader/model/SendFeedbackModel.dart';

class FirestoreService{
final CollectionReference _userCollectionReference = Firestore.instance.collection('Feedback');


sendFeedBack(SendFeedBackModel sendFeedBackModel)async{
try{
   await _userCollectionReference.document(sendFeedBackModel.id).setData(
      sendFeedBackModel.toJson());
  }catch(e){
    return e.message; 
  }
}

}