import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Başlangıç durumu
class AuthInitial extends AuthState {}

// 🔹 Kullanıcı giriş yaptı
class Authenticated extends AuthState {
  final User user;
  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// 🔹 Kullanıcı çıkış yaptı
class Unauthenticated extends AuthState {}

// 🔹 Hata durumu
class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

// 🔹 Yüklenme durumu
class AuthLoading extends AuthState {}
