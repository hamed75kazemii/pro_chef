import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../services/demo_recipe_service.dart';
import 'root_controller.dart';

class RecipeController extends GetxController {
  // Use demo service for testing, change to RecipeService for production
  final RecipeService _recipeService = RecipeService();
  final DemoRecipeService _demoService = DemoRecipeService();

  final RxList<Recipe> recipes = <Recipe>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedFilter = ''.obs;

  final List<String> availableFilters = [
    '',
    'Vegetarian',
    'Quick meals (under 30 minutes)',
    'Low calorie',
    'High protein',
    'Gluten-free',
  ];

  // Persian translations for filters
  final Map<String, String> _filterTranslations = {
    'Vegetarian': 'گیاهی',
    'Quick meals (under 30 minutes)': 'غذاهای سریع (کمتر از 30 دقیقه)',
    'Low calorie': 'کم کالری',
    'High protein': 'پروتئین بالا',
    'Gluten-free': 'بدون گلوتن',
  };

  String getTranslatedFilter(String filter) {
    if (RootController.to.currentLanguage == 'fa') {
      return _filterTranslations[filter] ?? filter;
    }
    return filter;
  }

  List<String> get availableFiltersTranslated {
    return availableFilters
        .map((filter) => getTranslatedFilter(filter))
        .toList();
  }

  Future<void> generateRecipes(List<String> ingredients) async {
    if (ingredients.isEmpty) {
      errorMessage.value = 'please_enter_ingredients'.tr;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Get current language for AI service
      final currentLanguage = RootController.to.currentLanguage;

      // Use demo service for testing (no API key required)
      final newRecipes = await _demoService.getRecipes(
        ingredients,
        filter: selectedFilter.value.isNotEmpty ? selectedFilter.value : null,
        language: currentLanguage,
      );

      // Uncomment the line below and comment the demo service line above to use real API
      // final newRecipes = await _recipeService.getRecipes(
      //   ingredients,
      //   filter: selectedFilter.value.isNotEmpty ? selectedFilter.value : null,
      //   language: currentLanguage,
      // );

      if (newRecipes.isEmpty) {
        errorMessage.value = 'no_recipes_found'.tr;
      } else {
        recipes.value = newRecipes;
        errorMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'ai_error'.tr;
      debugPrint('Error in controller: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void clearRecipes() {
    recipes.clear();
    errorMessage.value = '';
  }

  void clearError() {
    errorMessage.value = '';
  }
}
