import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/iranian_recipe.dart';

class IranianRecipesService {
  static IranianRecipesService? _instance;
  static IranianRecipesService get instance =>
      _instance ??= IranianRecipesService._();

  IranianRecipesService._();

  IranianRecipesData? _recipesData;

  Future<IranianRecipesData> loadRecipes() async {
    if (_recipesData != null) {
      return _recipesData!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/iranian_recipes.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _recipesData = IranianRecipesData.fromJson(jsonData);
      return _recipesData!;
    } catch (e) {
      print('Error loading Iranian recipes: $e');
      // Return empty data if loading fails
      return IranianRecipesData(recipes: []);
    }
  }

  Future<List<IranianRecipe>> getWhatToCookRecipes() async {
    final data = await loadRecipes();
    return data.getWhatToCookRecipes();
  }

  Future<List<IranianRecipe>> getAllRecipes() async {
    final data = await loadRecipes();
    return data.recipes;
  }

  Future<List<IranianRecipe>> getSimpleRecipes() async {
    final data = await loadRecipes();
    return data.getSimpleRecipes();
  }

  Future<List<IranianRecipe>> getAvailableIngredientsRecipes() async {
    final data = await loadRecipes();
    return data.getAvailableIngredientsRecipes();
  }

  Future<List<IranianRecipe>> getRandomRecipes(
    List<IranianRecipe> alreadySelected,
  ) async {
    final data = await loadRecipes();
    return data.getRandomRecipes(alreadySelected);
  }
}
