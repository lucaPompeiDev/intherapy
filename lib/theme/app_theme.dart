import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette colori del sito, secondo richiesta:
/// - bianco
/// - RGB(153, 85, 101)  -> tonalità principale (malva/rosa antico)
/// - RGB(248, 230, 164) -> tonalità secondaria (crema/oro chiaro)
class AppColors {
  AppColors._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color.fromRGBO(153, 85, 101, 1); // #995565
  static const Color secondary = Color.fromRGBO(248, 230, 164, 1); // #F8E6A4

  // Tonalità derivate (solo per sfumature, non colori nuovi nella palette)
  static const Color primaryDark = Color(0xFF7A4350);
  static const Color primaryLight = Color(0xFFB98A97);
  static const Color secondarySoft = Color(0xFFFBF1D8);
  static const Color textDark = Color(0xFF3A2A2E);
}

class AppRadius {
  AppRadius._();

  static const double xl = 40;
  static const double lg = 32;
  static const double md = 24;
  static const double sm = 16;
}

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
    );

    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
        height: 1.15,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark.withOpacity(0.8),
        height: 1.5,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
