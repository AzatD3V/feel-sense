class UserModel {
  final List<String> hobbies;
  final List<String> musicStyle;
  final List<String> personalityStyle;
  final List<double> emotions;
  final List<String> responses;
  String? response = '';

  UserModel(
      {required this.hobbies,
      required this.musicStyle,
      required this.personalityStyle,
      required this.emotions,
      required this.responses,
      this.response});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
        response: data["lastResponse"],
        hobbies: List<String>.from(data["hobbies"]),
        musicStyle: List<String>.from(data["music"]),
        personalityStyle: List<String>.from(data["personality"]),
        emotions: List<double>.from(data["emotions"]),
        responses: List<String>.from(data["response"]));
  }

  Map<String, dynamic> toMap() {
    return {
      "hobbies": hobbies,
      "music": musicStyle,
      "personality": personalityStyle,
      "emotions": emotions,
      "response": responses,
      "lastResponse": response
    };
  }
}
