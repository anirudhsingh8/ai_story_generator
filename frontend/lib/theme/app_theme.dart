import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // App Colors
  static const Color darkNavy = Color(0xFF222831);
  static const Color darkGrey = Color(0xFF31363F);
  static const Color teal = Color(0xFF76ABAE);
  static const Color lightGrey = Color(0xFFEEEEEE);

  // Text Theme
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.nunito(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: lightGrey,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: lightGrey,
    ),
    displaySmall: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: lightGrey,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: lightGrey,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: lightGrey,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: 16,
      color: lightGrey,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 14,
      color: lightGrey,
    ),
    labelLarge: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: lightGrey,
    ),
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: teal,
    scaffoldBackgroundColor: darkNavy,
    appBarTheme: AppBarTheme(
      backgroundColor: darkNavy,
      elevation: 0,
      titleTextStyle: textTheme.titleLarge,
      iconTheme: const IconThemeData(color: lightGrey),
    ),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: teal, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      labelStyle: textTheme.bodyMedium,
      hintStyle:
          textTheme.bodyMedium?.copyWith(color: lightGrey.withOpacity(0.5)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(teal),
        foregroundColor: WidgetStateProperty.all(darkNavy),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        textStyle: WidgetStateProperty.all(
            textTheme.labelLarge?.copyWith(color: darkNavy)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(teal),
        side: WidgetStateProperty.all(const BorderSide(color: teal)),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        textStyle: WidgetStateProperty.all(
            textTheme.labelLarge?.copyWith(color: teal)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(teal),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
        textStyle: WidgetStateProperty.all(
            textTheme.labelLarge?.copyWith(color: teal)),
      ),
    ),
    cardTheme: CardTheme(
      color: darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),
    dividerTheme: const DividerThemeData(
      color: teal,
      thickness: 1,
      space: 24,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(darkNavy),
      fillColor: WidgetStateProperty.all(teal),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(teal),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? darkNavy : lightGrey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? teal : darkGrey;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: teal,
      inactiveTrackColor: darkGrey,
      thumbColor: teal,
      overlayColor: teal.withOpacity(0.2),
    ),
    colorScheme: ColorScheme.dark(
      primary: teal,
      secondary: teal,
      surface: darkGrey,
      onPrimary: darkNavy,
      onSecondary: darkNavy,
      onSurface: lightGrey,
      error: Colors.red.shade300,
      onError: lightGrey,
    ),
  );
}
