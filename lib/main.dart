import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipe_manager/app.dart';
import 'package:recipe_repository/recipe_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final RecipeRepository recipesRepository = RecipeRepository();

  // Load favorites using Drift.
  final AppDatabase database = AppDatabase();
  final FavoriteRepository favoritesRepository = FavoriteRepository(
    database: database,
  );
  await favoritesRepository.loadFavorites();

  runApp(
    RecipeApp(
      recipesRepository: recipesRepository,
      favoritesRepository: favoritesRepository,
    ),
  );
}
