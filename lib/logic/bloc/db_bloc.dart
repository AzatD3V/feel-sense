import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xxx/logic/bloc/db_event.dart';
import 'package:xxx/logic/bloc/db_state.dart';
import 'package:xxx/services/db_services.dart';

class DBBlock extends Bloc<DBEvent, DBState> {
  final DBServices _services;
  DBBlock(this._services) : super(DBInitialized()) {
    on<AddUserData>(_onAddUserData);
  }

  FutureOr<void> _onAddUserData(
      AddUserData event, Emitter<DBState> emit) async {
    try {
      emit(DBInitialized());
      await _services.addInfo(event.user);
      emit(DBLoading());
      emit(DBSucces(message: "Data save succes."));
    } catch (e) {
      throw Exception('Services Error');
    }
  }
}
