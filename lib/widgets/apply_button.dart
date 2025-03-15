import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyButton extends StatefulWidget {
  final Widget screen;
  final List<String> selectedOptions;
  const ApplyButton(
      {super.key, required this.screen, required this.selectedOptions});

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.selectedOptions.length <= 4
                  ? Colors.black
                  : Colors.green),
          onPressed: () {
            if (widget.selectedOptions.length >= 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => widget.screen));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('data')));
            }
          },
          child: Text(
            "Next",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
    );
  }
}
