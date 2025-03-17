import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipe_manager/app.dart';
import 'package:recipe_manager/recipe/cubit/favorite_cubit.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/recipe.dart';
import 'package:recipe_manager/recipe/view/favorites_page.dart';
import 'package:recipe_repository/recipe_repository.dart';

void main() {
  testWidgets('Repositories are registered', (WidgetTester tester) async {
    final RecipeRepository recipesRepository = RecipeRepository();
    final AppDatabase database = AppDatabase();
    final FavoriteRepository favoritesRepository = FavoriteRepository(
      database: database,
    );
    await tester.pumpWidget(
      RecipeApp(
        recipesRepository: recipesRepository,
        favoritesRepository: favoritesRepository,
      ),
    );
    final context = tester.firstElement(find.byType(TabBarView));
    expect(RepositoryProvider.of<RecipeRepository>(context), isNotNull);
    expect(RepositoryProvider.of<FavoriteRepository>(context), isNotNull);
    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();
  });

  testWidgets('Cubits are registered', (WidgetTester tester) async {
    final RecipeRepository recipesRepository = RecipeRepository();
    final AppDatabase database = AppDatabase();
    final FavoriteRepository favoritesRepository = FavoriteRepository(
      database: database,
    );
    await tester.pumpWidget(
      RecipeApp(
        recipesRepository: recipesRepository,
        favoritesRepository: favoritesRepository,
      ),
    );

    final context = tester.firstElement(find.byType(TabBarView));
    expect(BlocProvider.of<RecipesCubit>(context), isNotNull);
    expect(BlocProvider.of<FavoriteCubit>(context), isNotNull);
    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();
  });

  testWidgets('FavoritesPage is shown by default', (WidgetTester tester) async {
    final RecipeRepository recipesRepository = RecipeRepository();
    final AppDatabase database = AppDatabase();
    final FavoriteRepository favoritesRepository = FavoriteRepository(
      database: database,
    );
    await tester.pumpWidget(
      RecipeApp(
        recipesRepository: recipesRepository,
        favoritesRepository: favoritesRepository,
      ),
    );

    expect(find.byType(TabBarView), findsOne);
    expect(find.byType(RecipesPage), findsOne);
    expect(find.byType(FavoritesPage), findsNothing);
    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();
  });

  testWidgets('Can switch to RecipesPage', (WidgetTester tester) async {
    final RecipeRepository recipesRepository = RecipeRepository();
    final AppDatabase database = AppDatabase();
    final FavoriteRepository favoritesRepository = FavoriteRepository(
      database: database,
    );
    await tester.pumpWidget(
      RecipeApp(
        recipesRepository: recipesRepository,
        favoritesRepository: favoritesRepository,
      ),
    );

    expect(find.byType(TabBarView), findsOne);
    expect(find.byType(RecipesPage), findsOne);
    expect(find.byType(FavoritesPage), findsNothing);

    // Tap on the destination icon and wait for animation to end.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    expect(find.byType(RecipesPage), findsNothing);
    expect(find.byType(FavoritesPage), findsOne);
    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();
  });
}
