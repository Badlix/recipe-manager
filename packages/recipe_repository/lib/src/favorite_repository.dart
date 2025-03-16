import 'dart:async';
import 'package:drift/drift.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipe_repository/recipe_repository.dart';

class FavoriteRepository {
  FavoriteRepository({required this.database});

  List<Recipe> _favoriteRecipes = [];
  final AppDatabase database;

  Future<void> loadFavorites() async {
    _favoriteRecipes = [];
    var favorites = await database.allFavorites;
    for (var favorite in favorites) {
      _favoriteRecipes.add(
        Recipe(id: favorite.id, name: favorite.name, imageUri: favorite.image),
      );
    }
  }

  List<Recipe> get favorites {
    return _favoriteRecipes;
  }

  Future<void> addFavorite(Recipe recipe) async {
    _favoriteRecipes.add(recipe);
    await database
        .into(database.favoriteRecipes)
        .insert(
          mode: InsertMode.replace,
          FavoriteRecipesCompanion.insert(
            id: recipe.id,
            name: recipe.name,
            image: recipe.imageUri,
          ),
        );
  }

  Future<void> removeFavorite(Recipe recipe) async {
    _favoriteRecipes.remove(recipe);
    await database.deleteFavorite(recipe.id);
  }

  void dispose() {}
}
