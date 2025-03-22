import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xxx/constant/options_list.dart';
import 'package:xxx/screens/info_screens/music_style_selection_screen.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'hobbies'.tr(),
        action: ApplyButton(
            screen: MusicStyleSelection(hobbies: selectedOptions),
            selectedOptions: selectedOptions),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  OptionButton(
                      title: 'choose_hobbies'.tr(),
                      options: OptionsList.hobbys,
                      selectedOptions: (value) {
                        setState(() {
                          selectedOptions = value;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
