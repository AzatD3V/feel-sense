import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionButton extends StatefulWidget {
  final List<String> options;
  final ValueChanged<List<String>> selectedOptions;
  final String title;
  const OptionButton(
      {super.key,
      required this.options,
      required this.selectedOptions,
      required this.title});

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  // Kullanıcının seçimlerini tutan yapı
  final List<String> selectedOptions = [];

  // Maksimum seçim sınırları
  final int maxSelections = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text(
                widget.title,
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Expanded(child: SizedBox()),
              Text(
                " ${selectedOptions.length.toString()} / ${maxSelections.toString()}",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: widget.options.map((item) {
            bool isSelected = selectedOptions.contains(item);

            return ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    selectedOptions.remove(item);
                    widget.selectedOptions(selectedOptions);
                  } else {
                    // Eğer maksimum sınır dolduysa uyarı ver
                    if (selectedOptions.length < maxSelections) {
                      selectedOptions.add(item);
                      widget.selectedOptions(selectedOptions);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "You can select up to $maxSelections in Hobbies."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.green : Colors.black,
                foregroundColor: isSelected ? Colors.black : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(item, style: TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
