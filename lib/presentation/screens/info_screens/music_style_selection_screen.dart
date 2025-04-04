import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xxx/core/constant/options_list.dart';
import 'package:xxx/presentation/screens/info_screens/personality_selection_screen.dart';
import 'package:xxx/presentation/widgets/apply_button.dart';
import 'package:xxx/presentation/widgets/option_button.dart';
import 'package:xxx/presentation/widgets/custom_appbar.dart';

class MusicStyleSelection extends StatefulWidget {
  final List<String> hobbies;
  const MusicStyleSelection({super.key, required this.hobbies});

  @override
  State<MusicStyleSelection> createState() => _MusicStyleSelectionState();
}

class _MusicStyleSelectionState extends State<MusicStyleSelection> {
  List<String> selectedOptions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'music'.tr(),
        action: ApplyButton(
            screen: ProfileScreen(
              hobbies: widget.hobbies,
              musicStyle: selectedOptions,
            ),
            selectedOptions: selectedOptions),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                children: [
                  OptionButton(
                      options: OptionsList.music,
                      selectedOptions: (value) {
                        setState(() {
                          selectedOptions = value;
                        });
                      },
                      title: 'choose_music'.tr()),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
