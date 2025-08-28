import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final RxString _originalSelectedFilter =
      ''.obs; // Store original English filter

  final List<String> availableFilters = [
    '',
    'Vegetarian',
    'Vegan',
    'Quick meals (under 30 minutes)',
    'Low calorie',
    'High protein',
    'Gluten-free',
    'Dairy-free',
    'Low carb',
    'Keto-friendly',
  ];

  // Persian translations for filters
  final Map<String, String> _filterTranslations = {
    'Vegetarian': 'گیاهی',
    'Vegan': 'وگان',
    'Quick meals (under 30 minutes)': 'غذاهای سریع (کمتر از 30 دقیقه)',
    'Low calorie': 'کم کالری',
    'High protein': 'پروتئین بالا',
    'Gluten-free': 'بدون گلوتن',
    'Dairy-free': 'بدون لبنیات',
    'Low carb': 'کم کربوهیدرات',
    'Keto-friendly': 'مناسب کتو',
  };

  // English to Persian mapping for reverse lookup
  final Map<String, String> _reverseFilterTranslations = {
    'گیاهی': 'Vegetarian',
    'وگان': 'Vegan',
    'غذاهای سریع (کمتر از 30 دقیقه)': 'Quick meals (under 30 minutes)',
    'کم کالری': 'Low calorie',
    'پروتئین بالا': 'High protein',
    'بدون گلوتن': 'Gluten-free',
    'بدون لبنیات': 'Dairy-free',
    'کم کربوهیدرات': 'Low carb',
    'مناسب کتو': 'Keto-friendly',
  };

  // Icons for each dietary preference
  final Map<String, IconData> _filterIcons = {
    '': Icons.restaurant_rounded,
    'Vegetarian': Icons.eco_rounded,
    'Vegan': Icons.spa_rounded,
    'Quick meals (under 30 minutes)': Icons.timer_rounded,
    'Low calorie': Icons.trending_down_rounded,
    'High protein': Icons.fitness_center_rounded,
    'Gluten-free': Icons.grain_rounded,
    'Dairy-free': Icons.local_drink_rounded,
    'Low carb': Icons.grain_rounded,
    'Keto-friendly': Icons.local_fire_department_rounded,
  };

  String getTranslatedFilter(String filter) {
    if (RootController.to.currentLanguage == 'fa') {
      return _filterTranslations[filter] ?? filter;
    }
    return filter;
  }

  String getOriginalFilter(String translatedFilter) {
    if (RootController.to.currentLanguage == 'fa') {
      return _reverseFilterTranslations[translatedFilter] ?? translatedFilter;
    }
    return translatedFilter;
  }

  List<String> get availableFiltersTranslated {
    return availableFilters
        .map((filter) => getTranslatedFilter(filter))
        .toList();
  }

  IconData getFilterIcon(String filter) {
    // Get the original English filter name for icon lookup
    final originalFilter = getOriginalFilter(filter);
    return _filterIcons[originalFilter] ?? Icons.restaurant_rounded;
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
        filter:
            selectedFilter.value.isNotEmpty
                ? getOriginalFilter(selectedFilter.value)
                : null,
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
    // Convert translated filter back to original for API calls
    final originalFilter = getOriginalFilter(filter);
    _originalSelectedFilter.value =
        originalFilter; // Store original English filter
    selectedFilter.value = filter; // Store the translated version for display
  }

  void updateSelectedFilterTranslation() {
    // Update the displayed filter when language changes
    if (_originalSelectedFilter.value.isNotEmpty) {
      selectedFilter.value = getTranslatedFilter(_originalSelectedFilter.value);
    }
  }

  void clearRecipes() {
    recipes.clear();
    errorMessage.value = '';
  }

  void clearError() {
    errorMessage.value = '';
  }
}
