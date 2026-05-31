import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ------------------------- 1. Color Palette (exactly from splash screen) -------------------------
  static const Color oatMilk = Color(0xFFF8E3C4);    // main canvas
  static const Color pollen = Color(0xFFF0C283);    // accent glow
  static const Color graphite = Color(0xFF5D6973);   // primary text / high contrast
  static const Color lovePotion = Color(0xFFCF6E6C); // deep branding accent
  static const Color ballerina = Color(0xFFDCA7A1);  // soft secondary accent

  // Additional semantic colors (optional, but useful)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1E262C);
  static const Color success = Color(0xFF86B3A0);
  static const Color error = lovePotion;

  // ------------------------- 2. Light Theme (main) -------------------------
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: oatMilk,
      primaryColor: lovePotion,
      colorScheme: const ColorScheme.light(
        primary: lovePotion,
        secondary: ballerina,
        tertiary: pollen,
        surface: oatMilk,
        error: error,
        onPrimary: white,
        onSecondary: graphite,
        onSurface: graphite,
        onError: white,
      ),

      // Text themes – elegant, editorial, with Google Fonts
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 64,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
          color: graphite,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: graphite,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: graphite,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: graphite,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: graphite,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: graphite,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: graphite,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: graphite.withOpacity(0.85),
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: lovePotion,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: graphite.withOpacity(0.6),
        ),
      ),

      // AppBar – transparent, elegant
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
          color: graphite,
        ),
        iconTheme: const IconThemeData(color: graphite),
      ),

      // Buttons – minimal, rounded, with lovePotion accents
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lovePotion,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: graphite,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: graphite,
          side: const BorderSide(color: ballerina, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8,
          ),
        ),
      ),

      // Input fields – soft, rounded, elegant
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ballerina.withOpacity(0.4), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: lovePotion, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        labelStyle: GoogleFonts.inter(color: graphite.withOpacity(0.7)),
        hintStyle: GoogleFonts.inter(color: graphite.withOpacity(0.5)),
      ),

      // Bottom navigation (if used)
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: oatMilk,
        elevation: 0,
        selectedItemColor: lovePotion,
        unselectedItemColor: graphite.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
      ),

      // Dividers – subtle
      dividerTheme: DividerThemeData(
        color: ballerina.withOpacity(0.3),
        thickness: 1,
        space: 24,
      ),
    );
  }

  // ------------------------- 3. Dark Theme (optional, consistent with brand) -------------------------
  static ThemeData dark() {
    const darkCanvas = Color(0xFF2C3338);
    const darkSurface = Color(0xFF1E2428);
    const darkText = Color(0xFFE8E2D9);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkCanvas,
      primaryColor: lovePotion,
      colorScheme: const ColorScheme.dark(
        primary: lovePotion,
        secondary: ballerina,
        tertiary: pollen,
        surface: darkSurface,
        error: error,
        onPrimary: white,
        onSecondary: darkText,
        onSurface: darkText,
        onError: white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(color: darkText),
        displayMedium: GoogleFonts.playfairDisplay(color: darkText),
        headlineLarge: GoogleFonts.playfairDisplay(color: darkText),
        bodyLarge: GoogleFonts.inter(color: darkText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkCanvas,
        titleTextStyle: GoogleFonts.playfairDisplay(color: darkText),
      ),
      // Other themes can be extended similarly for dark mode
    );
  }
}