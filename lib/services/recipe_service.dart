import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../constants/app_config.dart';

class RecipeService {
  // API configuration from AppConfig
  static final String _apiKey = AppConfig.liaraApiKey;
  static const String _baseUrl = AppConfig.liaraBaseUrl;

  Future<List<Recipe>> getRecipes(
    List<String> ingredients, {
    String? filter,
    String language = 'en',
  }) async {
    try {
      final prompt = _buildPrompt(ingredients, filter);
      print("API KEY: $_apiKey");
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': AppConfig.liaraModel,
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful and concise cooking assistant. Always respond ONLY with valid JSON, no explanations or extra text. The JSON must be an array of recipes as described.',
            },
            {
              'role': 'user',
              'content': '''
$prompt
Please write your answer ONLY as a JSON array of 3 recipes, each with "name", "description", and "steps" fields. Do not include any text before or after the JSON. All output must be in $language.
''',
            },
          ],
          'temperature': 0.7,
        }),
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];

        // Try to parse the JSON response
        try {
          final jsonData = jsonDecode(content);
          if (jsonData is List) {
            return jsonData.map((item) => Recipe.fromJson(item)).toList();
          } else if (jsonData['recipes'] is List) {
            return (jsonData['recipes'] as List)
                .map((item) => Recipe.fromJson(item))
                .toList();
          }
        } catch (e) {
          // If JSON parsing fails, try to extract recipes from text
          return _parseRecipesFromText(content);
        }
      }

      return [];
    } catch (e) {
      debugPrint('Error fetching recipes: $e');
      return [];
    }
  }

  String _buildPrompt(List<String> ingredients, String? filter) {
    String prompt = '''
User has the following ingredients: ${ingredients.join(', ')}.

Suggest 3 meals using only these ingredients.
''';

    if (filter != null && filter.isNotEmpty) {
      prompt += '\nAdditional requirements: $filter';
    }

    prompt += '''

Return JSON with this exact format:
[
  {
    "name": "Recipe Name",
    "description": "Brief description of the recipe",
    "steps": [
      "Step 1 instruction",
      "Step 2 instruction",
      "Step 3 instruction"
    ]
  }
]

Make sure the response is valid JSON and each recipe has a name, description, and steps array.
''';

    return prompt;
  }

  List<Recipe> _parseRecipesFromText(String text) {
    // Fallback parsing if JSON parsing fails
    final recipes = <Recipe>[];
    final lines = text.split('\n');

    String currentName = '';
    String currentDescription = '';
    List<String> currentSteps = [];

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      if (trimmedLine.contains('Recipe') || trimmedLine.contains('Meal')) {
        // Save previous recipe if exists
        if (currentName.isNotEmpty) {
          recipes.add(
            Recipe(
              name: currentName,
              description: currentDescription,
              steps: List.from(currentSteps),
            ),
          );
        }

        currentName = trimmedLine;
        currentDescription = '';
        currentSteps.clear();
      } else if (trimmedLine.contains('Step') ||
          trimmedLine.contains('1.') ||
          trimmedLine.contains('2.')) {
        currentSteps.add(trimmedLine);
      } else if (currentDescription.isEmpty && !trimmedLine.contains('Step')) {
        currentDescription = trimmedLine;
      }
    }

    // Add the last recipe
    if (currentName.isNotEmpty) {
      recipes.add(
        Recipe(
          name: currentName,
          description: currentDescription,
          steps: List.from(currentSteps),
        ),
      );
    }

    return recipes;
  }
}
