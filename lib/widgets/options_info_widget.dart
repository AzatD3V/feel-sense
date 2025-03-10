import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsInfoWidget extends StatelessWidget {
  final List<String> options;
  final String title;
  const OptionsInfoWidget(
      {super.key, required this.options, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(color: Colors.black, blurRadius: 4)]),
        ),
        SizedBox(
          height: 15,
        ),
        Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: options.map((item) {
              return Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white, //Color(0xffed6f63),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black, blurRadius: 1, spreadRadius: 0.4)
                    ]),
                child: Text(
                  item,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              );
            }).toList())
      ],
    );
  }
}
