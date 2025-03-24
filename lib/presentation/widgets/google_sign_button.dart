import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/logic/blocs/auth/auth_bloc.dart';
import 'package:xxx/logic/blocs/auth/auth_event.dart';

class GoogleSignButton extends StatelessWidget {
  const GoogleSignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 600.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.7,
        child: GestureDetector(
          onTap: () => context.read<AuthBloc>().add(SignInWithGoogle()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.google,
                color: Colors.black,
              ),
              Text(
                'google_sign'.tr(),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Icon(
                FontAwesomeIcons.google,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
