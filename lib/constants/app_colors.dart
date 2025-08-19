import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Mint Green to Warm Orange Gradient
  static const Color mintGreen = Color(0xFF4CAF50);
  static const Color warmOrange = Color(0xFFFF9800);

  // Secondary Colors
  static const Color charcoal = Color(0xFF333333);
  static const Color pureWhite = Color(0xFFFFFFFF);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    stops: [0.40, 0.60],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [mintGreen, warmOrange],
  );

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = charcoal;
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);

  // Card Colors
  static const Color cardBackground = pureWhite;
  static const Color cardShadow = Color(0x1A000000);

  // Button Colors
  static const Color buttonPrimary = warmOrange;
  static const Color buttonSecondary = mintGreen;
  static const Color buttonText = pureWhite;

  // Icon Colors
  static const Color iconPrimary = warmOrange;
  static const Color iconSecondary = mintGreen;
  static const Color iconLight = Color(0xFFCCCCCC);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Input Colors
  static const Color inputBackground = Color(0xFFF8F9FA);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocus = mintGreen;

  // App Bar Colors
  static const Color appBarBackground = pureWhite;
  static const Color appBarText = charcoal;
  static const Color appBarIcon = warmOrange;
}
