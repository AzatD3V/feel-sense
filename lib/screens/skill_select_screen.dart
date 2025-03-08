import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/screens/next_screen.dart';
import 'package:xxx/widgets/custom_appbar.dart';

class HobbiesSelectionScreen extends StatefulWidget {
  const HobbiesSelectionScreen({super.key});

  @override
  State<HobbiesSelectionScreen> createState() => _HobbiesSelectionScreenState();
}

class _HobbiesSelectionScreenState extends State<HobbiesSelectionScreen> {
  // Kullanıcının seçimlerini tutan yapı
  final List<String> selectedOptions = [];

  // Maksimum seçim sınırları
  final int maxSelections = 5;
  // Kategori seçenekleri
  final List<String> options = [
    "📚 Reading",
    "✍️ Writing",
    "🎨 Drawing",
    "🖌️ Painting",
    "📷 Photography",
    "🎸 Playing Guitar",
    "🎹 Playing Piano",
    "🎤 Singing",
    "💃 Dancing",
    "🍳 Cooking",
    "🎂 Baking",
    "🌱 Gardening",
    "⛰️ Hiking",
    "🏃 Running",
    "🚴 Cycling",
    "🏊 Swimming",
    "🎣 Fishing",
    "⛺ Camping",
    "♟️ Chess",
    "🎮 Playing Video Games",
    "🎬 Watching Movies",
    "🎥 Watching Anime",
    "🛠️ DIY Projects",
    "🧶 Knitting",
    "🧘 Yoga",
    "🕉️ Meditation",
    "🖋️ Calligraphy",
    "🔨 Woodworking",
    "🛹 Skateboarding",
    "🏄 Surfing",
    "🧗 Rock Climbing",
    "✈️ Traveling",
    "🌍 Learning Languages",
    "🔭 Astronomy",
    "🐎 Horseback Riding",
    "💻 Coding"
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 2))),
            child: Row(
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
                  " ${selectedOptions.length.toString()} / ${maxSelections.toString()}",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              backgroundColor: isSelected
                                  ? Color(0xffed6f63)
                                  : Colors.grey.shade800,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            child: Text(item, style: TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: selectedOptions.length <= 4
                                    ? Colors.grey.shade800
                                    : Color(0xffed6f63)),
                            onPressed: () {
                              if (selectedOptions.length >= 5) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NextScreen(
                                            hobbies: selectedOptions)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('data')));
                              }
                            },
                            child: Text(
                              "Next Page",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
