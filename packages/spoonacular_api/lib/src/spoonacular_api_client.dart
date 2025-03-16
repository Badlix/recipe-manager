import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spoonacular_api/spoonacular_api.dart';
import 'package:spoonacular_api/src/models/recipe_details.dart';

class RecipeRequestFailure implements Exception {}

class RecipeNotFoundFailure implements Exception {}

class SpoonacularApiClient {
  SpoonacularApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const _baseUrlSpoonacular = 'api.spoonacular.com';

  final http.Client _httpClient;

  // GET '/recipes/complexSearch?query=(query)'
  Future<List<Recipe>> recipeSearch(String query) async {
    final recipeRequest =
        Uri.https(_baseUrlSpoonacular, '/recipes/complexSearch', {
          'apiKey': const String.fromEnvironment('SPOONACULAR_KEY'),
          'query': query,
          'number': '10',
        });

    final recipeResponse = await _httpClient.get(recipeRequest);

    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;

    if (!recipeJson.containsKey('results')) throw RecipeNotFoundFailure();

    final results = recipeJson['results'] as List;

    if (results.isEmpty) throw RecipeNotFoundFailure();

    List<Recipe> recipes = [];
    for (var recipe in results) {
      recipes.add(Recipe.fromJson(recipe as Map<String, dynamic>));
    }
    // List<Recipe> recipes = [];
    // for (var i = 0; i < 5; i++) {
    //   recipes.add(
    //     Recipe(
    //       id: i,
    //       title: "Recette $i",
    //       image:
    //           "https://assistanteplus.fr/wp-content/uploads/2022/04/chat-midjourney.webp",
    //     ),
    //   );
    // }

    return recipes;
  }

  // GET '/recipes/{id}/information'
  Future<RecipeDetails> getRecipeDetail(int id) async {
    final recipeRequest = Uri.https(
      _baseUrlSpoonacular,
      '/recipes/$id/information',
      {'apiKey': const String.fromEnvironment('SPOONACULAR_KEY')},
    );

    final recipeResponse = await _httpClient.get(recipeRequest);

    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;

    if (!recipeJson.containsKey('id')) throw RecipeNotFoundFailure();

    if (recipeJson.isEmpty) throw RecipeNotFoundFailure();

    return RecipeDetails.fromJson(recipeJson as Map<String, dynamic>);
  }

  void close() {
    _httpClient.close();
  }
}
