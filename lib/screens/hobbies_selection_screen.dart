import 'package:flutter/material.dart';
import 'package:xxx/constant/options_list.dart';
import 'package:xxx/screens/music_style_selection_screen.dart';
import 'package:xxx/widgets/apply_button.dart';
import 'package:xxx/widgets/option_button.dart';
import 'package:xxx/widgets/custom_appbar.dart';

class HobbiesSelectionScreen extends StatefulWidget {
  const HobbiesSelectionScreen({super.key});

  @override
  State<HobbiesSelectionScreen> createState() => _HobbiesSelectionScreenState();
}

class _HobbiesSelectionScreenState extends State<HobbiesSelectionScreen> {
  List<String> selectedOptions = [];
  // Kategori seçenekleri

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2926),
      appBar: CustomAppbar(title: 'Hobbies'),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  OptionButton(
                      title: 'Choose your Hobbies',
                      options: OptionsList.hobbys,
                      selectedOptions: (value) {
                        setState(() {
                          selectedOptions = value;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ApplyButton(
                      screen: MusicStyleSelection(hobbies: selectedOptions),
                      selectedOptions: selectedOptions)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
