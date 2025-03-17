class UserModel {
  final List<String> hobbies;
  final List<String> musicStyle;
  final List<String> personalityStyle;

  UserModel(
      {required this.hobbies,
      required this.musicStyle,
      required this.personalityStyle});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      hobbies: List<String>.from(data["hobbies"]),
      musicStyle: List<String>.from(data["music"]),
      personalityStyle: List<String>.from(data["personality"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "hobbies": hobbies,
      "music": musicStyle,
      "personality": personalityStyle
    };
  }
}
