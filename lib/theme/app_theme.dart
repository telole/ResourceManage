import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color tokens — kept in one place so the palette is a deliberate choice,
/// not scattered magic hex values.
class AppColors {
  static const primary = Color(0xFF5B3FF0); // deep violet
  static const primarySoft = Color(0xFFEDE8FF); // lavender tint for chips/bg
  static const background = Color(0xFFF7F6FC); // near-white lavender
  static const surface = Color(0xFFFFFFFF);
  static const gold = Color(0xFFF5A623); // accent for highlights/points
  static const textPrimary = Color(0xFF1E1B2E);
  static const textSecondary = Color(0xFF6B6580);
  static const success = Color(0xFF17B26A);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).copyWith(
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primarySoft,
        elevation: 0,
      ),
    );
  }
}
