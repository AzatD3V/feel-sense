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

  Future<UserModel> getInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Current user not found.');
      }
      final uid = currentUser.uid;
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        throw Exception("User data not found.");
      }
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
