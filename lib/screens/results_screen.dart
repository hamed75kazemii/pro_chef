import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  void _shareResults() {
    final RecipeController controller = Get.find<RecipeController>();

    if (controller.recipes.isEmpty) {
      return;
    }

    final String shareText = '''
👨‍🍳 ${'app_title'.tr} - ${'recipe_results'.tr}

🍽️ ${'found_recipes'.tr} ${controller.recipes.length} ${'delicious_recipes'.tr}!

📋 ${'recipes'.tr}:
${controller.recipes.take(5).map((recipe) => '• ${recipe.name}').join('\n')}
${controller.recipes.length > 5 ? '\n... ${'and_more'.tr} ${controller.recipes.length - 5} ${'more'.tr}!' : ''}

✨ ${'generated_with_pro_chef'.tr}

#ProChef #RecipeGenerator #Cooking
''';

    Share.share(shareText, subject: '${'check_out_these_recipes'.tr}');
  }

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find<RecipeController>();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),

        title: Row(
          children: [
            Image.asset('assets/icon/chef_pro.png', width: 28, height: 28),
            const SizedBox(width: 10),
            Text('recipes_found'.tr),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _shareResults();
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 20),
            ),
            tooltip: 'share_results'.tr,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.recipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppColors.iconLight,
                ),
                const SizedBox(height: 16),
                Text(
                  'no_recipes_found'.tr,
                  style: AppTextTheme.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'try_different_ingredients'.tr,
                  style: AppTextTheme.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.recipes[index];
            return RecipeCard(recipe: recipe);
          },
        );
      }),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  void _shareSingleRecipe(Recipe recipe) {
    final String shareText = '''
🍽️ ${recipe.name}

📝 Description:
${recipe.description}

📋 Instructions:
${recipe.steps.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}

👨‍🍳 Shared from Pro Chef App
''';

    Share.share(shareText, subject: 'Check out this recipe: ${recipe.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Get.to(() => RecipeDetailScreen(recipe: recipe));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.pureWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: AppTextTheme.cardTitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${recipe.steps.length} steps',
                          style: AppTextTheme.cardSubtitle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: AppColors.mintGreen,
                      size: 20,
                    ),
                    onPressed: () => _shareSingleRecipe(recipe),
                    tooltip: 'share_recipe'.tr,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                recipe.description,
                style: AppTextTheme.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.timer, size: 16, color: AppColors.iconLight),
                  const SizedBox(width: 4),
                  Text(
                    "tap_to_view_full_recipe".tr,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.warmOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
