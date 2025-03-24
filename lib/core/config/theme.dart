import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme
  static ThemeData get light {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        secondaryHeaderColor: Colors.black,
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.black,
            contentTextStyle: GoogleFonts.montserrat(
              color: Colors.white,
            )),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),

        // Text theme area
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
              fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black),
          displayMedium: GoogleFonts.montserrat(
              fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
          displaySmall: GoogleFonts.montserrat(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
          headlineLarge: GoogleFonts.montserrat(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: GoogleFonts.montserrat(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          headlineSmall: GoogleFonts.montserrat(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: GoogleFonts.montserrat(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: GoogleFonts.montserrat(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
          bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: Colors.black),
          bodySmall: GoogleFonts.montserrat(fontSize: 12, color: Colors.black),
        ));
  }

  // Dark Theme
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      secondaryHeaderColor: Colors.white,
      snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: GoogleFonts.montserrat(
            color: Colors.black,
          )),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),

      // Text theme area
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
            fontSize: 57, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: GoogleFonts.montserrat(
            fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: GoogleFonts.montserrat(
            fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: GoogleFonts.montserrat(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: GoogleFonts.montserrat(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        headlineSmall: GoogleFonts.montserrat(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: GoogleFonts.montserrat(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: GoogleFonts.montserrat(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        titleSmall: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
        bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: Colors.white),
        bodySmall: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
