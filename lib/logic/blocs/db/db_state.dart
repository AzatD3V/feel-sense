import 'package:equatable/equatable.dart';

abstract class DBState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DBInitialized extends DBState {}

class DBLoading extends DBState {}

class DBSucces extends DBState {
  final String message;

  DBSucces({required this.message});

  @override
  List<Object?> get props => [message];
}

class DBError extends DBState {
  final String error;

  DBError({required this.error});

  @override
  List<Object> get props => [error];
}
