import 'package:flutter/material.dart';

class ClassRushColors {
  static const orange = Color(0xFFFF7A1A);
  static const orangeDark = Color(0xFFE96508);
  static const charcoal = Color(0xFF20242B);
  static const lightBackground = Color(0xFFF6F7F9);
  static const darkBackground = Color(0xFF15181D);
}

class ClassRushTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme.fromSeed(
      seedColor: ClassRushColors.orange,
      brightness: brightness,
      primary: ClassRushColors.orange,
      surface: isDark
          ? const Color(0xFF20242B)
          : Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? ClassRushColors.darkBackground
          : ClassRushColors.lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? ClassRushColors.charcoal
            : Colors.white,
        foregroundColor: isDark
            ? Colors.white
            : ClassRushColors.charcoal,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? const Color(0xFF292E36)
            : const Color(0xFFF6F7F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ClassRushColors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

