import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Kullanıcı oturum açmak istiyor
class SignInWithGoogle extends AuthEvent {}

// 🔹 Kullanıcı çıkış yapmak istiyor
class SignOut extends AuthEvent {}

// 🔹 Kullanıcı oturum durumunu kontrol et
class CheckAuthStatus extends AuthEvent {}
