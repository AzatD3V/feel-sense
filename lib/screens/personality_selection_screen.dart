import 'package:flutter/material.dart';
import 'package:xxx/constant/options_list.dart';
import 'package:xxx/screens/selection_check_screen.dart';
import 'package:xxx/widgets/apply_button.dart';
import 'package:xxx/widgets/custom_appbar.dart';
import 'package:xxx/widgets/option_button.dart';

class ProfileScreen extends StatefulWidget {
  final List<String> hobbies;
  final List<String> musicStyle;
  const ProfileScreen(
      {super.key, required this.hobbies, required this.musicStyle});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Personality'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                OptionButton(
                    options: OptionsList.personalityTypes,
                    selectedOptions: (value) {
                      setState(() {
                        selectedOptions = value;
                      });
                    },
                    title: 'Choose your Personality'),
                SizedBox(
                  height: 20,
                ),
                ApplyButton(
                    screen: SelectionCheckScreen(
                        hobbies: widget.hobbies,
                        musicStyle: widget.musicStyle,
                        personalityStyle: selectedOptions),
                    selectedOptions: selectedOptions)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
