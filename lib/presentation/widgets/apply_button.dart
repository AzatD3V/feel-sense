import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
            if (widget.selectedOptions.length >= 2) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => widget.screen));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(textAlign: TextAlign.center, 'choose_two'.tr())));
            }
          },
          icon: Icon(
            Icons.arrow_forward,
            color: widget.selectedOptions.length >= 2
                ? Colors.green
                : Colors.white,
          )),
    );
  }
}
