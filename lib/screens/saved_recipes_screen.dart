import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/saved_recipes_controller.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SavedRecipesController controller = Get.put(SavedRecipesController());

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        title: Row(
          children: [
            Image.asset('assets/icon/chef_pro.png', width: 28, height: 28),
            const SizedBox(width: 10),
            Text('saved_recipes'.tr),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            if (controller.savedRecipes.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.delete_sweep, color: AppColors.appBarIcon),
              onPressed: () => _showClearAllDialog(context, controller),
              tooltip: 'clear_all'.tr,
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.savedRecipes.isEmpty) {
          return _buildEmptyState();
        }

        return _buildRecipesList(controller);
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.mintGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.favorite_border,
              size: 60,
              color: AppColors.mintGreen,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'no_saved_recipes'.tr,
            style: AppTextTheme.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'saved_recipes_description'.tr,
            style: AppTextTheme.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesList(SavedRecipesController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.savedRecipes.length,
      itemBuilder: (context, index) {
        final recipe = controller.savedRecipes[index];
        return _buildRecipeCard(recipe, controller);
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe, SavedRecipesController controller) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Get.to(() => RecipeDetailScreen(recipe: recipe)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.pureWhite,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: AppTextTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${recipe.steps.length} steps',
                      style: AppTextTheme.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.description,
                      style: AppTextTheme.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => _showDeleteDialog(recipe, controller),
                tooltip: 'remove_recipe'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Recipe recipe, SavedRecipesController controller) {
    Get.dialog(
      AlertDialog(
        title: Text('remove_recipe_title'.tr),
        content: Text('remove_recipe_message'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              controller.removeRecipe(recipe);
              Get.back();
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text('recipe_removed'.tr),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text(
              'remove'.tr,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(
    BuildContext context,
    SavedRecipesController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text('clear_all_recipes_title'.tr),
        content: Text('clear_all_recipes_message'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              controller.clearAllSavedRecipes();
              Get.back();
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text('all_recipes_cleared'.tr),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text(
              'clear_all'.tr,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
