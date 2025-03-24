import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/core/constant/constant_list.dart';

class ResponseListWidget extends StatelessWidget {
  final List<double> listEmotions;
  final List<String> responses;
  const ResponseListWidget(
      {super.key, required this.listEmotions, required this.responses});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 350,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 0.3)
            ],
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: ListView.builder(
          itemCount: responses.length,
          itemBuilder: (context, index) {
            double emotionValue = listEmotions[index];
            String emotionText = ConstantList.emotions[emotionValue.toInt()];
            String responseText = responses[index];

            return Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.grey])),
              height: 70,
              child: ListTile(
                onTap: () {
                  showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        actionsAlignment: MainAxisAlignment.center,
                        title: Text(
                          emotionText,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        content: SingleChildScrollView(
                          child: Text(
                            responseText,
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Close",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      );
                    },
                  );
                },
                title: Text(
                  emotionText,
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
                subtitle: Text(
                  responseText,
                  maxLines: 1,
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ),
    );
  }
}
