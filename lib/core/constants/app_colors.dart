import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette — deep indigo/violet
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9C94FF);
  static const Color primaryDark = Color(0xFF3D35CC);

  // Accent / income green
  static const Color income = Color(0xFF00D68F);
  static const Color incomeLight = Color(0xFFB3F5E0);

  // Expense red/coral
  static const Color expense = Color(0xFFFF6B6B);
  static const Color expenseLight = Color(0xFFFFD5D5);

  // Warning / balance amber
  static const Color balance = Color(0xFFFFB347);
  static const Color balanceLight = Color(0xFFFFE4B5);

  // Dark theme backgrounds
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF1E1E35);
  static const Color cardDark2 = Color(0xFF252540);

  // Light theme backgrounds
  static const Color backgroundLight = Color(0xFFF5F5FF);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  // Text colours
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0CC);
  static const Color textMuted = Color(0xFF6B6B90);

  // Category colours for charts
  static const List<Color> categoryColors = [
    Color(0xFF6C63FF),
    Color(0xFF00D68F),
    Color(0xFFFF6B6B),
    Color(0xFFFFB347),
    Color(0xFF4FC3F7),
    Color(0xFFBA68C8),
    Color(0xFF4DB6AC),
  ];

  // Gradient presets
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF3D35CC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient incomeGradient = LinearGradient(
    colors: [Color(0xFF00D68F), Color(0xFF00A86B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient expenseGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFCC3333)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient balanceGradient = LinearGradient(
    colors: [Color(0xFFFFB347), Color(0xFFFF8C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
