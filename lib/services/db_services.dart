import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  Future<void> addInfo(List<String> hobbies, List<String> music,
      List<String> personality) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Current user not found.');
      }
      final uid = currentUser.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set(
          {"hobbies": hobbies, "music": music, "personality": personality},
          SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error 404');
    }
  }
}
