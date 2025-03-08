import 'package:flutter/material.dart';
import 'package:xxx/widgets/custom_appbar.dart';

class NextScreen extends StatefulWidget {
  final List<String> hobbies;
  const NextScreen({super.key, required this.hobbies});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Music'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.hobbies.toString())],
        ),
      ),
    );
  }
}
