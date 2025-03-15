import 'package:flutter/material.dart';

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
      child: IconButton(
          onPressed: () {
            if (widget.selectedOptions.length >= 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => widget.screen));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('data')));
            }
          },
          icon: Icon(
            Icons.arrow_forward,
            color: widget.selectedOptions.length == 5
                ? Colors.green
                : Colors.white,
          )),
    );
  }
}
