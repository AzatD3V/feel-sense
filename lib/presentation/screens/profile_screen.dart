import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xxx/presentation/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: CustomAppbar(title: "Profile"),
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(currentUser!.photoURL!),
            ),
          ),
          Text(
            currentUser.displayName!,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
