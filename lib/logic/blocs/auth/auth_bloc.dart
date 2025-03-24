import 'package:bloc/bloc.dart';
import 'package:xxx/data/repositories/auth_services.dart';
import 'package:xxx/logic/blocs/auth/auth_event.dart';
import 'package:xxx/logic/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices;

  AuthBloc({required AuthServices authServices})
      : _authServices = authServices,
        super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignOut>(_onSignOut);
  }

  // 🔹 Kullanıcının oturum durumunu kontrol et
  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    final user = _authServices.currentUser;
    if (user != null) {
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  // 🔹 Google ile giriş yap
  Future<void> _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authServices.signInWithGoogle();
      if (user == null) {
        emit(AuthError(message: "Google oturumu açma iptal edildi"));
      } else {
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(message: "Giriş başarısız: $e"));
    }
  }

  // 🔹 Kullanıcı çıkış yaparsa
  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authServices.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(message: "Çıkış işlemi başarısız: $e"));
    }
  }
}
