import 'dart:async';

class FavoriteRepository {
  FavoriteRepository({List<int>? favoriteRecipesIds})
    : _favoriteRecipesIds = favoriteRecipesIds ?? [];

  final List<int> _favoriteRecipesIds;

  Future<List<int>> getFavorites() async {
    return _favoriteRecipesIds;
  }

  Future<void> addFavorite(int recipeId) async {
    _favoriteRecipesIds.add(recipeId);
  }

  Future<void> removeFavorite(int recipeId) async {
    _favoriteRecipesIds.remove(recipeId);
  }

  void dispose() {}
}
