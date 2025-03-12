import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spoonacular_api/spoonacular_api.dart';

/// Exception thrown when recipeSearch fails.
class RecipeRequestFailure implements Exception {}

/// Exception thrown when the provided recipe is not found.
class RecipeNotFoundFailure implements Exception {}

/// {@template spoonacular_api_client}
/// Dart API Client which wraps the [Spooncacular API](https://api.spoonacular.com).
/// {@endtemplate}
class SpoonacularApiClient {
  /// {@macro spoonacular_api_client}
  SpoonacularApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const _baseUrlSpoonacular = 'api.spoonacular.com';

  final http.Client _httpClient;

  /// Finds [Recipe] `/recipes/complexSearch?query=(query)`.
  Future<List<Recipe>> recipeSearch(String query) async {
    final recipeRequest = Uri.https(
      _baseUrlSpoonacular,
      '/recipes/complexSearch',
      {
        'apiKey': "45e151b1f38d40a5b1a2a9d46a9c05a1",
        'query': query,
        'number': '10',
      },
    );

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

    return recipes;
  }

  /// Finds [Recipe] `/recipes/{id}/information`.
  Future<Recipe> getRecipeDetail(int id) async {
    final recipeRequest = Uri.https(
      _baseUrlSpoonacular,
      '/recipes/$id/information',
      {'apiKey': "45e151b1f38d40a5b1a2a9d46a9c05a1"},
    );

    final recipeResponse = await _httpClient.get(recipeRequest);

    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;

    if (!recipeJson.containsKey('id')) throw RecipeNotFoundFailure();

    if (recipeJson.isEmpty) throw RecipeNotFoundFailure();

    return Recipe.fromJson(recipeJson as Map<String, dynamic>);
  }

  void close() {
    _httpClient.close();
  }
}
