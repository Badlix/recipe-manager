import 'dart:async';

import 'package:spoonacular_api/spoonacular_api.dart' hide Recipe;
import 'package:recipe_repository/recipe_repository.dart';

class RecipeRepository {
  RecipeRepository({SpoonacularApiClient? spoonacularApiClient})
    : _spoonacularApiClient = spoonacularApiClient ?? SpoonacularApiClient();

  final SpoonacularApiClient _spoonacularApiClient;

  Future<List<Recipe>> searchRecipes(String searchText) async {
    var recipes = await _spoonacularApiClient.recipeSearch(searchText);
    return recipes
        .map(
          (recipe) =>
              Recipe(id: recipe.id, name: recipe.title, imageUri: recipe.image),
        )
        .toList();
  }

  Future<RecipeDetails> getRecipeDetail(int id) async {
    final recipe = await _spoonacularApiClient.getRecipeDetail(id);
    return RecipeDetails(
      id: recipe.id,
      name: recipe.title,
      imageUri: recipe.image,
      ingredients: recipe.extendedIngredients,
      steps: recipe.analyzedInstructions,
    );
  }

  void dispose() => _spoonacularApiClient.close();
}
