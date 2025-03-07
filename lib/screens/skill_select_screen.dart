import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/widgets/custom_appbar.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  // Kullanıcının seçimlerini tutan yapı
  final List<String> selectedOptions = [];

  // Maksimum seçim sınırları
  final int maxSelections = 5;
  // Kategori seçenekleri
  final List<String> options = [
    "Reading",
    "Gaming",
    "Cooking",
    "Cycling",
    "Fishing",
    "Dancing",
    "Singing",
    "Drawing",
    "Photography",
    "Baking",
    "Hiking",
    "Swimming",
    "Running",
    "Traveling",
    "Acting",
    "Yoga",
    "Knitting",
    "Puzzle Solving",
    "Chess",
    "Writing"
  ];

  // Firebase'e kaydetme fonksiyonu
  /* void saveToFirebase() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/user123");
    ref.set(selectedOptions);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2926),
      appBar: CustomAppbar(title: 'Hobbies'),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Choose your Hobbies',
                    style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                      " ${selectedOptions.length.toString()} / ${maxSelections.toString()}")
                ],
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((item) {
                  bool isSelected = selectedOptions.contains(item);

                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          selectedOptions.remove(item);
                        } else {
                          // Eğer maksimum sınır dolduysa uyarı ver
                          if (selectedOptions.length < maxSelections) {
                            selectedOptions.add(item);
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
                      backgroundColor:
                          isSelected ? Colors.green : Colors.grey.shade800,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20), // Kategoriler arası boşluk
            ],
          ),
        ),
      ),
    );
  }
}
