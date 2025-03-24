import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xxx/core/constant/options_list.dart';
import 'package:xxx/presentation/screens/info_screens/selection_check_screen.dart';
import 'package:xxx/presentation/widgets/apply_button.dart';
import 'package:xxx/presentation/widgets/custom_appbar.dart';
import 'package:xxx/presentation/widgets/option_button.dart';

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
      appBar: CustomAppbar(
        title: 'personality'.tr(),
        action: ApplyButton(
            screen: SelectionCheckScreen(
                hobbies: widget.hobbies,
                musicStyle: widget.musicStyle,
                personalityStyle: selectedOptions),
            selectedOptions: selectedOptions),
      ),
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
                    title: 'choose_person'.tr()),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
