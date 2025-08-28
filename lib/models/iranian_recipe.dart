class IranianRecipe {
  final int id;
  final Map<String, String> name;
  final Map<String, String> ingredients;
  final Map<String, String> cookingTime;
  final Map<String, String> foodType;
  final Map<String, String> instructions;
  final bool ingredientsAvailable;
  final bool simpleRecipe;

  IranianRecipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.cookingTime,
    required this.foodType,
    required this.instructions,
    required this.ingredientsAvailable,
    required this.simpleRecipe,
  });

  factory IranianRecipe.fromJson(Map<String, dynamic> json) {
    return IranianRecipe(
      id: json['id'] ?? 0,
      name: Map<String, String>.from(json['name'] ?? {}),
      ingredients: Map<String, String>.from(json['ingredients'] ?? {}),
      cookingTime: Map<String, String>.from(json['cookingTime'] ?? {}),
      foodType: Map<String, String>.from(json['foodType'] ?? {}),
      instructions: Map<String, String>.from(json['instructions'] ?? {}),
      ingredientsAvailable: json['ingredientsAvailable'] ?? false,
      simpleRecipe: json['simpleRecipe'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'cookingTime': cookingTime,
      'foodType': foodType,
      'instructions': instructions,
      'ingredientsAvailable': ingredientsAvailable,
      'simpleRecipe': simpleRecipe,
    };
  }

  String getName(String language) {
    return name[language] ?? name['en'] ?? '';
  }

  String getIngredients(String language) {
    return ingredients[language] ?? ingredients['en'] ?? '';
  }

  String getCookingTime(String language) {
    return cookingTime[language] ?? cookingTime['en'] ?? '';
  }

  String getFoodType(String language) {
    return foodType[language] ?? foodType['en'] ?? '';
  }

  String getInstructions(String language) {
    return instructions[language] ?? instructions['en'] ?? '';
  }

  @override
  String toString() {
    return 'IranianRecipe(id: $id, name: $name, ingredientsAvailable: $ingredientsAvailable, simpleRecipe: $simpleRecipe)';
  }
}

class IranianRecipesData {
  final List<IranianRecipe> recipes;

  IranianRecipesData({required this.recipes});

  factory IranianRecipesData.fromJson(Map<String, dynamic> json) {
    final recipesList = json['recipes'] as List<dynamic>? ?? [];
    return IranianRecipesData(
      recipes:
          recipesList
              .map((recipeJson) => IranianRecipe.fromJson(recipeJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'recipes': recipes.map((recipe) => recipe.toJson()).toList()};
  }

  // Get simple recipes (first 3)
  List<IranianRecipe> getSimpleRecipes() {
    return recipes.where((recipe) => recipe.simpleRecipe).take(3).toList();
  }

  // Get recipes with available ingredients (next 2)
  List<IranianRecipe> getAvailableIngredientsRecipes() {
    return recipes
        .where((recipe) => recipe.ingredientsAvailable)
        .take(2)
        .toList();
  }

  // Get random recipes (last 2, avoiding repetition)
  List<IranianRecipe> getRandomRecipes(List<IranianRecipe> alreadySelected) {
    final availableRecipes =
        recipes.where((recipe) => !alreadySelected.contains(recipe)).toList();

    if (availableRecipes.length < 2) return availableRecipes;

    availableRecipes.shuffle();
    return availableRecipes.take(2).toList();
  }

  // Get 7 recipes for "What to Cook" feature
  List<IranianRecipe> getWhatToCookRecipes() {
    final List<IranianRecipe> selectedRecipes = [];

    // Add simple recipes (first 3)
    selectedRecipes.addAll(getSimpleRecipes());

    // Add available ingredients recipes (next 2)
    selectedRecipes.addAll(getAvailableIngredientsRecipes());

    // Add random recipes (last 2)
    selectedRecipes.addAll(getRandomRecipes(selectedRecipes));

    return selectedRecipes;
  }
}
