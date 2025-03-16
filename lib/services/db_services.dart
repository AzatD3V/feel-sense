import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xxx/model/user_model.dart';

class DBServices {
  Future<void> addInfo(UserModel user) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Current user not found.');
      }
      final uid = currentUser.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "hobbies": user.hobbies,
        "music": user.musicStyle,
        "personality": user.personalityStyle
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error 404');
    }
  }
}
