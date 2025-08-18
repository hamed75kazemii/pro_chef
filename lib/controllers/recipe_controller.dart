import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../services/demo_recipe_service.dart';

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

  Future<void> generateRecipes(List<String> ingredients) async {
    if (ingredients.isEmpty) {
      errorMessage.value = 'Please enter at least one ingredient';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Use demo service for testing (no API key required)
      final newRecipes = await _demoService.getRecipes(
        ingredients,
        filter: selectedFilter.value.isNotEmpty ? selectedFilter.value : null,
      );

      // Uncomment the line below and comment the demo service line above to use real API
      // final newRecipes = await _recipeService.getRecipes(
      //   ingredients,
      //   filter: selectedFilter.value.isNotEmpty ? selectedFilter.value : null,
      // );

      if (newRecipes.isEmpty) {
        errorMessage.value =
            'No recipes found. Try different ingredients or filters.';
      } else {
        recipes.value = newRecipes;
        errorMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Failed to generate recipes. Please try again.';
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
