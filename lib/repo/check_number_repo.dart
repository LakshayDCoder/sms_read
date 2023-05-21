import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms_read/utils/constants.dart';

class CheckNumberRepo {
  var firestore = FirebaseFirestore.instance;

  Future<bool> isNumberSafe(String phone) async {
    DocumentSnapshot docRef =
        await firestore.collection(numbersCollection).doc(phone).get();

    return !docRef.exists;
  }
}
