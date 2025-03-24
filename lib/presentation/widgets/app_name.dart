import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppName extends StatelessWidget {
  final double width;
  final double height;
  const AppName({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width * 0.2,
      top: height * 0.53,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            'Sense',
            style: GoogleFonts.cinzel(
                fontSize: 50,
                color: Colors.black,
                shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
          ),
          Positioned(top: -35, left: 25, child: singleChar('F')),
          Positioned(top: 40, left: 24, child: singleChar('E')),
          Positioned(top: 80, left: 24, child: singleChar('L'))
        ],
      ),
    );
  }
}

Widget singleChar(String singleChar) {
  return Text(
    textAlign: TextAlign.start,
    singleChar,
    style: GoogleFonts.cinzel(
        fontSize: 50,
        color: Colors.black,
        shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
  );
}
