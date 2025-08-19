import 'package:flutter/material.dart';
import 'app_colors.dart';

class SplashConstants {
  // Animation durations
  static const Duration iconAnimationDuration = Duration(milliseconds: 1500);
  static const Duration textAnimationDuration = Duration(milliseconds: 1000);
  static const Duration gradientAnimationDuration = Duration(
    milliseconds: 2000,
  );
  static const Duration particleAnimationDuration = Duration(
    milliseconds: 4000,
  );

  // Animation delays
  static const Duration iconDelay = Duration(milliseconds: 300);
  static const Duration textDelay = Duration(milliseconds: 500);
  static const Duration navigationDelay = Duration(milliseconds: 3000);

  // Icon dimensions
  static const double iconSize = 140.0;
  static const double iconPadding = 28.0;
  static const double iconBorderRadius = 70.0;

  // Text styles
  static const double titleFontSize = 42.0;
  static const double subtitleFontSize = 16.0;
  static const double loadingFontSize = 15.0;
  static const double loadingSubFontSize = 12.0;

  // Spacing
  static const double titleSpacing = 50.0;
  static const double subtitleSpacing = 12.0;
  static const double loadingSpacing = 20.0;
  static const double bottomSpacing = 50.0;
  static const double topSpacing = 100.0;

  // Shadow properties
  static const double titleShadowBlur = 4.0;
  static const Offset titleShadowOffset = Offset(0, 2);
  static const double iconShadowBlur = 30.0;
  static const double iconShadowSpread = 10.0;
  static const double iconShadowBlurSecondary = 20.0;
  static const double iconShadowSpreadSecondary = 5.0;

  // Particle properties
  static const double particleBaseSize = 18.0;
  static const double particleMaxSize = 6.0;
  static const double particleBaseOpacity = 0.4;
  static const double particleMaxOpacity = 0.3;
  static const double particleMovement = 25.0;

  // Gradient properties
  static const double backgroundAlpha = 0.05;
  static const double titleShadowAlpha = 0.3;
  static const double iconShadowAlpha = 0.4;
  static const double iconShadowAlphaSecondary = 0.3;
  static const double subtitleBackgroundAlpha = 0.1;
  static const double subtitleBorderAlpha = 0.3;

  // Particle positions and icons
  static const List<Map<String, dynamic>> particles = [
    {
      'left': 50.0,
      'top': 100.0,
      'icon': Icons.restaurant,
      'color': AppColors.mintGreen,
    },
    {
      'left': 300.0,
      'top': 150.0,
      'icon': Icons.local_pizza,
      'color': AppColors.warmOrange,
    },
    {
      'left': 80.0,
      'top': 300.0,
      'icon': Icons.cake,
      'color': AppColors.mintGreen,
    },
    {
      'left': 320.0,
      'top': 400.0,
      'icon': Icons.coffee,
      'color': AppColors.warmOrange,
    },
    {
      'left': 150.0,
      'top': 200.0,
      'icon': Icons.icecream,
      'color': AppColors.mintGreen,
    },
    {
      'left': 280.0,
      'top': 350.0,
      'icon': Icons.local_dining,
      'color': AppColors.warmOrange,
    },
  ];

  // Text content
  static const String appTitle = 'Pro Chef';
  static const String appSubtitle = '⭐ AI Recipe Generator';
  static const String loadingText = 'Preparing your kitchen...';
  static const String loadingSubText = 'Loading AI chef assistant';

  // Border radius
  static const double subtitleBorderRadius = 20.0;
  static const double subtitleBorderWidth = 1.0;

  // Letter spacing
  static const double titleLetterSpacing = 2.0;
  static const double subtitleLetterSpacing = 0.5;
  static const double loadingLetterSpacing = 0.5;
}
