import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/root_controller.dart';
import '../models/iranian_recipe.dart';
import '../services/iranian_recipes_service.dart';
import 'iranian_recipe_detail_screen.dart';

class WhatToCookScreen extends StatefulWidget {
  const WhatToCookScreen({super.key});

  @override
  State<WhatToCookScreen> createState() => _WhatToCookScreenState();
}

class _WhatToCookScreenState extends State<WhatToCookScreen> {
  final RootController rootController = Get.find<RootController>();
  final IranianRecipesService _recipesService = IranianRecipesService.instance;

  List<IranianRecipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final recipes = await _recipesService.getWhatToCookRecipes();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'what_to_cook'.tr,
          style: AppTextTheme.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.mintGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.restaurant_rounded,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'what_to_cook_description'.tr,
                            style: AppTextTheme.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Simple Recipes Section (First 3)
                    if (_recipes.length >= 3) ...[
                      // _buildSectionHeader(
                      //   'simple_recipes'.tr,
                      //   Icons.star_rounded,
                      //   AppColors.warmOrange,
                      // ),
                      // const SizedBox(height: 12),
                      ..._recipes
                          .take(3)
                          .map((recipe) => _buildRecipeCard(recipe)),
                      //     const SizedBox(height: 24),
                    ],

                    // Available Ingredients Section (Next 2)
                    if (_recipes.length >= 5) ...[
                      // _buildSectionHeader(
                      //   'available_ingredients'.tr,
                      //   Icons.check_circle_rounded,
                      //   AppColors.mintGreen,
                      // ),
                      // const SizedBox(height: 12),
                      ..._recipes
                          .skip(3)
                          .take(2)
                          .map((recipe) => _buildRecipeCard(recipe)),
                      //  const SizedBox(height: 24),
                    ],

                    // Random Suggestions Section (Last 2)
                    if (_recipes.length >= 7) ...[
                      // _buildSectionHeader(
                      //   'random_suggestions'.tr,
                      //   Icons.shuffle_rounded,
                      //   AppColors.info,
                      // ),
                      // const SizedBox(height: 12),
                      ..._recipes
                          .skip(5)
                          .take(2)
                          .map((recipe) => _buildRecipeCard(recipe)),
                    ],
                  ],
                ),
              ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextTheme.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeCard(IranianRecipe recipe) {
    final language = rootController.currentLanguage;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Get.to(() => IranianRecipeDetailScreen(recipe: recipe)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      recipe.getName(language),
                      style: AppTextTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mintGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe.getFoodType(language),
                      style: AppTextTheme.bodySmall.copyWith(
                        color: AppColors.mintGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    recipe.getCookingTime(language),
                    style: AppTextTheme.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.restaurant_rounded,
                    size: 16,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    recipe.getFoodType(language),
                    style: AppTextTheme.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                recipe.getIngredients(language),
                style: AppTextTheme.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (recipe.simpleRecipe)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warmOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'simple'.tr,
                        style: AppTextTheme.bodySmall.copyWith(
                          color: AppColors.warmOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  if (recipe.ingredientsAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'available_ingredients_badge'.tr,
                        style: AppTextTheme.bodySmall.copyWith(
                          color: AppColors.mintGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed:
                        () => Get.to(
                          () => IranianRecipeDetailScreen(recipe: recipe),
                        ),
                    child: Text(
                      'view_recipe'.tr,
                      style: AppTextTheme.bodyMedium.copyWith(
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
    );
  }
}
