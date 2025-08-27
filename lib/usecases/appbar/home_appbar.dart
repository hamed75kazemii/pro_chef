import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_chef/constants/app_images.dart';
import 'package:pro_chef/constants/app_text_theme.dart';
import 'package:pro_chef/constants/screen_utills.dart';
import 'package:pro_chef/screens/saved_recipes_screen.dart';
import 'package:pro_chef/screens/settings_screen.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 50, height: 50, child: AppImages.logo),
        const SizedBox(width: 5),
        Text(
          'Pro Chef',
          style: AppTextTheme.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        Spacer(),
        // Saved Recipes Button
        Container(
          margin: const EdgeInsets.only(right: 8, left: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              Get.to(() => const SavedRecipesScreen());
            },
            icon: const Icon(
              Icons.bookmark_outline,
              color: Colors.white,
              size: 24,
            ),
            tooltip: 'saved_recipes'.tr,
          ),
        ),
        // Share App Button
        // ShareApp(),
        // Settings Button
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
            icon: const Icon(Icons.settings, color: Colors.white, size: 24),
            tooltip: 'settings'.tr,
          ),
        ),
      ],
    );
  }
}
