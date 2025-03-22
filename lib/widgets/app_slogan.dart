import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSlogan extends StatelessWidget {
  final double width;
  final double height;
  const AppSlogan({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: width * 0.7,
        top: height * 0.45,
        child: Container(
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 12, right: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Text(
            textAlign: TextAlign.center,
            "Mood\nFace\nFeel\nRead\nTalk",
            style: GoogleFonts.bungee(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
