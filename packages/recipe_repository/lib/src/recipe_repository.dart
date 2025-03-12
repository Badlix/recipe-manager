import 'dart:async';

import 'package:spoonacular_api/spoonacular_api.dart' hide Recipe;
import 'package:recipe_repository/recipe_repository.dart';

class RecipeRepository {
  RecipeRepository({SpoonacularApiClient? spoonacularApiClient})
    : _spoonacularApiClient = spoonacularApiClient ?? SpoonacularApiClient();

  final SpoonacularApiClient _spoonacularApiClient;

  Future<List<Recipe>> searchRecipes(String searchText) async {
    final result = await _spoonacularApiClient.recipeSearch(searchText);
    List<Recipe> recipes = [];
    for (var element in result) {
      recipes.add(
        Recipe(id: element.id, name: element.title, imageUri: element.image),
      );
    }

    return recipes;
  }

  Future<Recipe> getRecipeDetail(int id) async {
    final recipe = await _spoonacularApiClient.getRecipeDetail(id);
    return Recipe(id: recipe.id, name: recipe.title, imageUri: recipe.image);
  }

  void dispose() => _spoonacularApiClient.close();
}
