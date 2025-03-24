class UserInfoModel {
  String userId;
  List<String> hobbies;
  List<String> skill;

  UserInfoModel(
      {required this.userId, required this.hobbies, required this.skill});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "hobbies": hobbies, "skill": skill};
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        userId: json["userId"],
        hobbies: List<String>.from(json["hobbies"]),
        skill: List<String>.from(json["skills"]));
  }
}
