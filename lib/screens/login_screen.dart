import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xxx/services/auth_services.dart';
import 'package:xxx/logic/bloc/auth_bloc.dart';
import 'package:xxx/logic/bloc/auth_state.dart';
import 'package:xxx/widgets/app_name.dart';
import 'package:xxx/widgets/app_slogan.dart';
import 'package:xxx/widgets/google_sign_button.dart';
import 'package:xxx/widgets/image_opacty.dart';
import 'package:xxx/widgets/nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavBar()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff2D2926),
        body: Stack(
          children: [
            FaceImage(
              width: width,
              height: height,
            ),
            AppName(width: width, height: height),
            AppSlogan(width: width, height: height),
            Center(
              child: GoogleSignButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class DenemeSayfa extends StatelessWidget {
  const DenemeSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
