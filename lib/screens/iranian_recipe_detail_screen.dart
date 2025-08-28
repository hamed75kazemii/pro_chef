import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../models/iranian_recipe.dart';
import '../controllers/root_controller.dart';

class IranianRecipeDetailScreen extends StatelessWidget {
  final IranianRecipe recipe;

  const IranianRecipeDetailScreen({super.key, required this.recipe});

  void _shareRecipe() {
    final language = Get.find<RootController>().currentLanguage;
    final String shareText = '''
🍽️ ${recipe.getName(language)}

⏱️ ${'cooking_time_label'.tr}: ${recipe.getCookingTime(language)}
🍽️ ${'food_type_label'.tr}: ${recipe.getFoodType(language)}

📋 ${'ingredients_label'.tr}:
${recipe.getIngredients(language)}

📝 ${'instructions_label'.tr}:
${recipe.getInstructions(language)}

👨‍🍳 ${'shared_from_pro_chef'.tr}
''';

    Share.share(
      shareText,
      subject: '${'check_out_this_recipe'.tr}: ${recipe.getName(language)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = Get.find<RootController>().currentLanguage;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        title: Row(
          children: [
            Image.asset('assets/icon/chef_pro.png', width: 28, height: 28),
            const SizedBox(width: 10),
            Text('instructions'.tr),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Header Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            color: AppColors.pureWhite,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.getName(language),
                                style: AppTextTheme.headlineSmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recipe.getFoodType(language),
                                style: AppTextTheme.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Recipe Info Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            Icons.access_time_rounded,
                            'cooking_time_label'.tr,
                            recipe.getCookingTime(language),
                            AppColors.mintGreen,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            Icons.restaurant_rounded,
                            'food_type_label'.tr,
                            recipe.getFoodType(language),
                            AppColors.warmOrange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Recipe Tags
                    Row(
                      children: [
                        if (recipe.simpleRecipe)
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warmOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.warmOrange.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'ساده',
                              style: AppTextTheme.bodySmall.copyWith(
                                color: AppColors.warmOrange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (recipe.ingredientsAvailable)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mintGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.mintGreen.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'مواد موجود',
                              style: AppTextTheme.bodySmall.copyWith(
                                color: AppColors.mintGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ingredients Section
            Text(
              'ingredients_label'.tr,
              style: AppTextTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  recipe.getIngredients(language),
                  style: AppTextTheme.bodyLarge.copyWith(
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Instructions Section
            Text(
              'instructions_label'.tr,
              style: AppTextTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Instructions
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  recipe.getInstructions(language),
                  style: AppTextTheme.bodyLarge.copyWith(
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _shareRecipe();
                    },
                    icon: const Icon(Icons.share),
                    label: Text('share_recipe'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonSecondary,
                      foregroundColor: AppColors.pureWhite,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextTheme.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextTheme.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
