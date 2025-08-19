import '../models/recipe.dart';

class DemoRecipeService {
  Future<List<Recipe>> getRecipes(
    List<String> ingredients, {
    String? filter,
    String language = 'en',
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate sample recipes based on ingredients
    final recipes = <Recipe>[];

    if (ingredients.any(
      (ingredient) => ingredient.toLowerCase().contains('chicken'),
    )) {
      recipes.add(
        _createRecipe(
          name: language == 'fa' ? 'مرغ سرخ شده' : 'Chicken Stir Fry',
          description:
              language == 'fa'
                  ? 'یک غذای سریع و خوشمزه با مرغ نرم و سبزیجات تازه.'
                  : 'A quick and delicious stir fry with tender chicken and fresh vegetables.',
          steps:
              language == 'fa'
                  ? [
                    'روغن را در یک ماهیتابه بزرگ روی حرارت بالا گرم کنید',
                    'مرغ خرد شده را اضافه کرده و تا طلایی شدن بپزید، حدود 5-7 دقیقه',
                    'سبزیجات خرد شده را اضافه کرده و 3-4 دقیقه سرخ کنید',
                    'با سس سویا، سیر و زنجبیل طعم دار کنید',
                    'داغ روی برنج یا نودل سرو کنید',
                  ]
                  : [
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
        _createRecipe(
          name:
              language == 'fa'
                  ? 'پاستا پریماورا ساده'
                  : 'Simple Pasta Primavera',
          description:
              language == 'fa'
                  ? 'یک غذای سبک و تازه پاستا با سبزیجات فصلی.'
                  : 'A light and fresh pasta dish with seasonal vegetables.',
          steps:
              language == 'fa'
                  ? [
                    'پاستا را طبق دستور بسته بندی بپزید',
                    'سیر خرد شده را در روغن زیتون تا معطر شدن تفت دهید',
                    'سبزیجات خرد شده را اضافه کرده و تا نرم شدن بپزید',
                    'با پاستای پخته شده مخلوط کرده و با نمک و فلفل طعم دار کنید',
                    'با سبزیجات تازه و پنیر رنده شده تزئین کنید',
                  ]
                  : [
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
        _createRecipe(
          name:
              language == 'fa'
                  ? 'تخم مرغ نیمرو با سبزیجات'
                  : 'Scrambled Eggs with Vegetables',
          description:
              language == 'fa'
                  ? 'یک صبحانه مغذی یا غذای سریع با سبزیجات تازه.'
                  : 'A nutritious breakfast or quick meal with fresh vegetables.',
          steps:
              language == 'fa'
                  ? [
                    'تخم مرغ‌ها را در یک کاسه شکسته و تا صاف شدن هم بزنید',
                    'کره را در یک تابه نچسب روی حرارت متوسط گرم کنید',
                    'سبزیجات خرد شده را اضافه کرده و 2-3 دقیقه بپزید',
                    'تخم مرغ‌های زده شده را ریخته و تا پختن به آرامی هم بزنید',
                    'با نمک، فلفل و سبزیجات طعم دار کنید',
                  ]
                  : [
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
        _createRecipe(
          name:
              language == 'fa'
                  ? 'سبزیجات سرخ شده ساده'
                  : 'Simple Vegetable Stir Fry',
          description:
              language == 'fa'
                  ? 'یک غذای سالم و سریع سبزیجات سرخ شده با مواد اولیه موجود شما.'
                  : 'A healthy and quick vegetable stir fry using your available ingredients.',
          steps:
              language == 'fa'
                  ? [
                    'روغن را در یک تابه بزرگ روی حرارت متوسط-بالا گرم کنید',
                    'سبزیجات خرد شده را اضافه کرده و 5-7 دقیقه سرخ کنید',
                    'با نمک، فلفل و ادویه‌های مورد علاقه‌تان طعم دار کنید',
                    'برای طعم بیشتر کمی سس سویا یا آب لیمو اضافه کنید',
                    'داغ به عنوان غذای اصلی یا کنار غذا سرو کنید',
                  ]
                  : [
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
      if (filter.toLowerCase().contains('vegetarian') ||
          filter.contains('گیاهی')) {
        recipes.removeWhere(
          (recipe) =>
              recipe.name.toLowerCase().contains('chicken') ||
              recipe.name.contains('مرغ'),
        );
      }
      if (filter.toLowerCase().contains('quick') || filter.contains('سریع')) {
        recipes.removeWhere((recipe) => recipe.steps.length > 4);
      }
    }

    return recipes;
  }

  Recipe _createRecipe({
    required String name,
    required String description,
    required List<String> steps,
  }) {
    return Recipe(name: name, description: description, steps: steps);
  }
}
