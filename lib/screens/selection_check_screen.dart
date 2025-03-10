import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/widgets/custom_appbar.dart';
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
    return Scaffold(
      backgroundColor: Color(0xff2D2926),
      appBar: const CustomAppbar(title: 'Check Info'),
      body: Padding(
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
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color(0xff2D2926),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {}, child: Text('OK')),
                              ],
                            )
                          ],
                          content: Text(
                            textAlign: TextAlign.center,
                            'Kaydedilen degisiklikler daha sonra geri degistirilemez, islemi onayliyor musun ? ',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          title: Text(
                            'Dikkat',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
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
      ),
    );
  }
}
