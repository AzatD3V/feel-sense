import 'package:flutter/material.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  // Kullanıcının seçimlerini tutan yapı
  final Map<String, List<String>> selectedOptions = {
    "Hobbies": [],
    "Skills": [],
    "Music": [],
    "Sports": []
  };

  // Maksimum seçim sınırları
  final Map<String, int> maxSelections = {
    "Hobbies": 5, // Kullanıcı en fazla 5 hobi seçebilir
    "Skills": 3, // Kullanıcı en fazla 3 beceri seçebilir
    "Music": 4, // Kullanıcı en fazla 4 müzik türü seçebilir
    "Sports": 2 // Kullanıcı en fazla 2 spor dalı seçebilir
  };

  // Kategori seçenekleri
  final Map<String, List<String>> options = {
    "Hobbies": [
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
    ],
    "Skills": [
      "Programming",
      "Communication",
      "Leadership",
      "Design",
      "Public Speaking",
      "Problem Solving",
      "Critical Thinking",
      "Time Management",
      "Marketing",
      "Negotiation",
      "Teaching",
      "Finance",
      "Data Analysis",
      "Sales",
      "Graphic Design",
      "Project Management",
      "Customer Service",
      "Writing",
      "Video Editing",
      "Photography"
    ],
    "Music": [
      "Pop",
      "Jazz",
      "Rock",
      "Classical",
      "Hip-hop",
      "Blues",
      "Metal",
      "Reggae",
      "Country",
      "Electronic",
      "Folk",
      "R&B",
      "Soul",
      "Indie",
      "Punk",
      "Funk",
      "Opera",
      "Disco",
      "House",
      "Techno"
    ],
    "Sports": [
      "Football",
      "Basketball",
      "Tennis",
      "Volleyball",
      "Swimming",
      "Cycling",
      "Running",
      "Skiing",
      "Skating",
      "Surfing",
      "Boxing",
      "MMA",
      "Golf",
      "Cricket",
      "Table Tennis",
      "Baseball",
      "Wrestling",
      "Fencing",
      "Archery",
      "Badminton"
    ]
  };

  // Firebase'e kaydetme fonksiyonu
  /* void saveToFirebase() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/user123");
    ref.set(selectedOptions);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Your Interests")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.keys.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: options[category]!.map((item) {
                      bool isSelected =
                          selectedOptions[category]!.contains(item);
                      int maxAllowed = maxSelections[category]!;

                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (isSelected) {
                              selectedOptions[category]!.remove(item);
                            } else {
                              // Eğer maksimum sınır dolduysa uyarı ver
                              if (selectedOptions[category]!.length <
                                  maxAllowed) {
                                selectedOptions[category]!.add(item);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "You can select up to $maxAllowed in $category."),
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
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
    );
  }
}
