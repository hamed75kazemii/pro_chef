import '../models/recipe.dart';

class DemoRecipeService {
  Future<List<Recipe>> getRecipes(
    List<String> ingredients, {
    String? filter,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate sample recipes based on ingredients
    final recipes = <Recipe>[];

    if (ingredients.any(
      (ingredient) => ingredient.toLowerCase().contains('chicken'),
    )) {
      recipes.add(
        Recipe(
          name: 'Chicken Stir Fry',
          description:
              'A quick and delicious stir fry with tender chicken and fresh vegetables.',
          steps: [
            'Heat oil in a large wok or skillet over high heat',
            'Add diced chicken and cook until golden brown, about 5-7 minutes',
            'Add chopped vegetables and stir fry for 3-4 minutes',
            'Season with soy sauce, garlic, and ginger',
            'Serve hot over rice or noodles',
          ],
        ),
      );
    }

    if (ingredients.any(
      (ingredient) =>
          ingredient.toLowerCase().contains('pasta') ||
          ingredient.toLowerCase().contains('noodles'),
    )) {
      recipes.add(
        Recipe(
          name: 'Simple Pasta Primavera',
          description: 'A light and fresh pasta dish with seasonal vegetables.',
          steps: [
            'Cook pasta according to package instructions',
            'Sauté minced garlic in olive oil until fragrant',
            'Add chopped vegetables and cook until tender',
            'Toss with cooked pasta and season with salt and pepper',
            'Garnish with fresh herbs and grated cheese',
          ],
        ),
      );
    }

    if (ingredients.any(
      (ingredient) => ingredient.toLowerCase().contains('eggs'),
    )) {
      recipes.add(
        Recipe(
          name: 'Scrambled Eggs with Vegetables',
          description:
              'A nutritious breakfast or quick meal with fresh vegetables.',
          steps: [
            'Crack eggs into a bowl and whisk until smooth',
            'Heat butter in a non-stick pan over medium heat',
            'Add diced vegetables and cook for 2-3 minutes',
            'Pour in beaten eggs and stir gently until cooked',
            'Season with salt, pepper, and herbs',
          ],
        ),
      );
    }

    // Add a generic recipe if no specific matches
    if (recipes.isEmpty) {
      recipes.add(
        Recipe(
          name: 'Simple Vegetable Stir Fry',
          description:
              'A healthy and quick vegetable stir fry using your available ingredients.',
          steps: [
            'Heat oil in a large pan over medium-high heat',
            'Add chopped vegetables and stir fry for 5-7 minutes',
            'Season with salt, pepper, and your favorite spices',
            'Add a splash of soy sauce or lemon juice for flavor',
            'Serve hot as a main dish or side',
          ],
        ),
      );
    }

    // Apply filter if specified
    if (filter != null && filter.isNotEmpty) {
      if (filter.toLowerCase().contains('vegetarian')) {
        recipes.removeWhere(
          (recipe) => recipe.name.toLowerCase().contains('chicken'),
        );
      }
      if (filter.toLowerCase().contains('quick')) {
        recipes.removeWhere((recipe) => recipe.steps.length > 4);
      }
    }

    return recipes;
  }
}
