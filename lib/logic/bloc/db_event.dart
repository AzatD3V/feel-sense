import 'package:equatable/equatable.dart';

abstract class DBEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserData extends DBEvent {
  final List<String> hobbies;
  final List<String> music;
  final List<String> personality;

  AddUserData(
      {required this.hobbies, required this.music, required this.personality});

  @override
  // TODO: implement props
  List<Object> get props => [hobbies, music, personality];
}
