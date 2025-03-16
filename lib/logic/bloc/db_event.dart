import 'package:equatable/equatable.dart';
import 'package:xxx/model/user_model.dart';

abstract class DBEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserData extends DBEvent {
  final UserModel user;

  AddUserData({required this.user});

  @override
  List<Object> get props => [user];
}
