import 'dart:async';

import 'package:recipe_repository/recipe_repository.dart';

class FavoriteRepository {
  FavoriteRepository({List<Recipe>? favoriteRecipes})
    : _favoriteRecipes = favoriteRecipes ?? [];

  final List<Recipe> _favoriteRecipes;

  Future<List<Recipe>> getFavorites() async {
    return _favoriteRecipes;
  }

  Future<void> addFavorite(Recipe recipe) async {
    _favoriteRecipes.add(recipe);
  }

  Future<void> removeFavorite(Recipe recipe) async {
    _favoriteRecipes.remove(recipe);
  }

  void dispose() {}
}
