import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/logic/blocs/db/db_bloc.dart';
import 'package:xxx/logic/blocs/db/db_event.dart';
import 'package:xxx/logic/blocs/db/db_state.dart';
import 'package:xxx/data/models/user_model.dart';
import 'package:xxx/presentation/widgets/custom_appbar.dart';
import 'package:xxx/presentation/widgets/nav_bar.dart';
import 'package:xxx/presentation/widgets/options_info_widget.dart';

class SelectionCheckScreen extends StatelessWidget {
  final List<String> hobbies;
  final List<String> musicStyle;
  final List<String> personalityStyle;
  const SelectionCheckScreen(
      {super.key,
      required this.hobbies,
      required this.musicStyle,
      required this.personalityStyle});

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel(
        emotions: [],
        responses: [],
        hobbies: hobbies,
        musicStyle: musicStyle,
        personalityStyle: personalityStyle);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          title: 'check_info'.tr(),
        ),
        body: BlocConsumer<DBBlock, DBState>(
          listener: (context, state) {
            if (state is DBSucces) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavBar()),
                (route) => false,
              );
            } else if (state is DBError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionsInfoWidget(options: hobbies, title: 'hobbies'.tr()),
                    OptionsInfoWidget(
                      options: musicStyle,
                      title: "music".tr(),
                    ),
                    OptionsInfoWidget(
                      options: personalityStyle,
                      title: 'personality'.tr(),
                    ),
                    if (state is DBLoading) CircularProgressIndicator(),
                    ElevatedButton(
                        onPressed: () {
                          context.read<DBBlock>().add(AddUserData(user: user));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 5),
                        child: Text(
                          'save_all'.tr(),
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
