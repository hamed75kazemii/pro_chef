import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../models/recipe.dart';
import '../controllers/saved_recipes_controller.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  void _shareRecipe() {
    final String shareText = '''
🍽️ ${recipe.name}

📝 ${'description'.tr}:
${recipe.description}

📋 ${'instructions'.tr}:
${recipe.steps.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}

👨‍🍳 ${'shared_from_pro_chef'.tr}
''';

    Share.share(
      shareText,
      subject: '${'check_out_this_recipe'.tr}: ${recipe.name}',
    );
  }

  @override
  Widget build(BuildContext context) {
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
                                recipe.name,
                                style: AppTextTheme.headlineSmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${recipe.steps.length} steps',
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
                    Text(
                      'Description',
                      style: AppTextTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.description,
                      style: AppTextTheme.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Steps Section
            Text(
              'instructions'.tr,
              style: AppTextTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Steps List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.steps.length,
              itemBuilder: (context, index) {
                final step = recipe.steps[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: AppTextTheme.labelLarge.copyWith(
                                color: AppColors.pureWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            step,
                            style: AppTextTheme.bodyLarge.copyWith(
                              height: 1.5,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final savedController = Get.find<SavedRecipesController>();
                    final isSaved = savedController.isRecipeSaved(recipe);

                    return ElevatedButton.icon(
                      onPressed: () {
                        if (isSaved) {
                          savedController.removeRecipe(recipe);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('recipe_removed_from_favorites'.tr),
                              backgroundColor: AppColors.buttonSecondary,
                            ),
                          );
                        } else {
                          savedController.saveRecipe(recipe);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('recipe_saved_to_favorites'.tr),
                              backgroundColor: AppColors.buttonSecondary,
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        isSaved ? 'remove_from_favorites'.tr : 'save_recipe'.tr,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        foregroundColor: AppColors.pureWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 12),
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
}
