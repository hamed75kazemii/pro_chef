import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Base text style with Poppins font
  static TextStyle _baseTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? regular,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  // Display styles (Large headings)
  static TextStyle get displayLarge => _baseTextStyle(
    fontSize: 48,
    fontWeight: extraBold,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => _baseTextStyle(
    fontSize: 42,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static TextStyle get displaySmall => _baseTextStyle(
    fontSize: 36,
    fontWeight: bold,
    height: 1.3,
    letterSpacing: -0.2,
  );

  // Headline styles
  static TextStyle get headlineLarge => _baseTextStyle(
    fontSize: 32,
    fontWeight: bold,
    height: 1.3,
    letterSpacing: -0.1,
  );

  static TextStyle get headlineMedium =>
      _baseTextStyle(fontSize: 28, fontWeight: semiBold, height: 1.4);

  static TextStyle get headlineSmall =>
      _baseTextStyle(fontSize: 24, fontWeight: semiBold, height: 1.4);

  // Title styles
  static TextStyle get titleLarge =>
      _baseTextStyle(fontSize: 22, fontWeight: semiBold, height: 1.4);

  static TextStyle get titleMedium =>
      _baseTextStyle(fontSize: 18, fontWeight: medium, height: 1.4);

  static TextStyle get titleSmall =>
      _baseTextStyle(fontSize: 16, fontWeight: medium, height: 1.4);

  // Body styles
  static TextStyle get bodyLarge =>
      _baseTextStyle(fontSize: 18, fontWeight: regular, height: 1.5);

  static TextStyle get bodyMedium =>
      _baseTextStyle(fontSize: 16, fontWeight: regular, height: 1.5);

  static TextStyle get bodySmall =>
      _baseTextStyle(fontSize: 14, fontWeight: regular, height: 1.5);

  // Label styles
  static TextStyle get labelLarge =>
      _baseTextStyle(fontSize: 16, fontWeight: medium, height: 1.4);

  static TextStyle get labelMedium =>
      _baseTextStyle(fontSize: 14, fontWeight: medium, height: 1.4);

  static TextStyle get labelSmall =>
      _baseTextStyle(fontSize: 12, fontWeight: medium, height: 1.4);

  // Special styles for the app
  static TextStyle get splashTitle => _baseTextStyle(
    fontSize: 42,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: 2.0,
  );

  static TextStyle get splashSubtitle => _baseTextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get buttonText =>
      _baseTextStyle(fontSize: 16, fontWeight: bold, height: 1.4);

  static TextStyle get cardTitle =>
      _baseTextStyle(fontSize: 20, fontWeight: semiBold, height: 1.3);

  static TextStyle get cardSubtitle =>
      _baseTextStyle(fontSize: 14, fontWeight: regular, height: 1.4);

  static TextStyle get inputLabel =>
      _baseTextStyle(fontSize: 14, fontWeight: medium, height: 1.4);

  static TextStyle get inputText =>
      _baseTextStyle(fontSize: 16, fontWeight: regular, height: 1.5);

  static TextStyle get errorText =>
      _baseTextStyle(fontSize: 14, fontWeight: medium, height: 1.4);

  static TextStyle get loadingText => _baseTextStyle(
    fontSize: 15,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get loadingSubText =>
      _baseTextStyle(fontSize: 12, fontWeight: regular, height: 1.4);

  // Color variants
  static TextStyle get primary => _baseTextStyle(color: AppColors.textPrimary);
  static TextStyle get secondary =>
      _baseTextStyle(color: AppColors.textSecondary);
  static TextStyle get textLight => _baseTextStyle(color: AppColors.textLight);
  static TextStyle get white => _baseTextStyle(color: AppColors.pureWhite);
  static TextStyle get orange => _baseTextStyle(color: AppColors.warmOrange);
  static TextStyle get green => _baseTextStyle(color: AppColors.mintGreen);
  static TextStyle get error => _baseTextStyle(color: AppColors.error);
  static TextStyle get success => _baseTextStyle(color: AppColors.success);

  // Complete TextTheme for Material App
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
