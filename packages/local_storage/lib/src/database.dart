import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class FavoriteRecipes extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get image => text()();
}

@DriftDatabase(tables: [FavoriteRecipes])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spoonacular_database');
  }

  Future<List<FavoriteRecipe>> get allFavorites =>
      select(favoriteRecipes).get();

  Future deleteFavorite(int id) {
    return (delete(favoriteRecipes)
      ..where((favorite) => favorite.id.isValue(id))).go();
  }
}
