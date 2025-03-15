import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: GoogleFonts.sarina(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
