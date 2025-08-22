import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/recipe.dart';

class SavedRecipesController extends GetxController {
  final RxList<Recipe> savedRecipes = <Recipe>[].obs;
  final RxBool isLoading = false.obs;

  static const String _storageKey = 'saved_recipes';

  @override
  void onInit() {
    super.onInit();
    loadSavedRecipes();
  }

  Future<void> loadSavedRecipes() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final recipesJson = prefs.getStringList(_storageKey) ?? [];

      final recipes =
          recipesJson.map((json) => Recipe.fromJson(jsonDecode(json))).toList();

      savedRecipes.value = recipes;
    } catch (e) {
      print('Error loading saved recipes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      // Check if recipe is already saved
      final isAlreadySaved = savedRecipes.any((r) => r.name == recipe.name);
      if (isAlreadySaved) {
        return; // Recipe already saved
      }

      // Add to list
      savedRecipes.add(recipe);

      // Save to storage
      await _saveToStorage();
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }

  Future<void> removeRecipe(Recipe recipe) async {
    try {
      savedRecipes.removeWhere((r) => r.name == recipe.name);
      await _saveToStorage();
    } catch (e) {
      print('Error removing recipe: $e');
    }
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recipesJson =
          savedRecipes.map((recipe) => jsonEncode(recipe.toJson())).toList();

      await prefs.setStringList(_storageKey, recipesJson);
    } catch (e) {
      print('Error saving to storage: $e');
    }
  }

  bool isRecipeSaved(Recipe recipe) {
    return savedRecipes.any((r) => r.name == recipe.name);
  }

  void clearAllSavedRecipes() {
    savedRecipes.clear();
    _saveToStorage();
  }
}
