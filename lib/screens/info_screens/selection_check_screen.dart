import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/logic/bloc/db_bloc.dart';
import 'package:xxx/logic/bloc/db_event.dart';
import 'package:xxx/logic/bloc/db_state.dart';
import 'package:xxx/model/user_model.dart';
import 'package:xxx/widgets/custom_appbar.dart';
import 'package:xxx/widgets/nav_bar.dart';
import 'package:xxx/widgets/options_info_widget.dart';

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
          title: 'Check Info',
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
                    OptionsInfoWidget(options: hobbies, title: 'Your Hobbies'),
                    OptionsInfoWidget(
                      options: musicStyle,
                      title: 'Your Music Style',
                    ),
                    OptionsInfoWidget(
                      options: personalityStyle,
                      title: 'Your Personality',
                    ),
                    if (state is DBLoading) CircularProgressIndicator(),
                    ElevatedButton(
                        onPressed: () {
                          context.read<DBBlock>().add(AddUserData(user: user));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 5),
                        child: Text(
                          'Save All',
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
