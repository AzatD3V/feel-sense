import 'package:flutter/material.dart';

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Sol alt köşe
    path.quadraticBezierTo(
      size.width / 2, size.height, // Orta nokta (oval eğim)
      size.width, size.height - 50, // Sağ alt köşe
    );
    path.lineTo(size.width, 0); // Sağ üst köşe
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
