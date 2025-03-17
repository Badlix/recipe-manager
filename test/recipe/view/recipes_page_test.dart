import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_manager/recipe/cubit/favorite_cubit.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/models/models.dart';
import 'package:recipe_manager/recipe/view/recipe_card.dart';
import 'package:recipe_manager/recipe/view/recipes_page.dart';
import 'package:recipe_repository/recipe_repository.dart' as recipe_repository;

class MockRecipeRepository extends Mock
    implements recipe_repository.RecipeRepository {}

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

class MockRecipe extends Mock implements recipe_repository.Recipe {}

final Recipe recipe1 = Recipe(
  id: 1,
  name: 'Carbonara',
  imageUri: 'https://noimage',
);
final Recipe recipe2 = Recipe(
  id: 2,
  name: 'Bolognaise',
  imageUri: 'https://noimage',
);

void main() {
  late recipe_repository.Recipe mockRecipe1;
  late recipe_repository.Recipe mockRecipe2;
  late recipe_repository.RecipeRepository recipesRepository;
  late RecipesCubit recipesCubit;
  late FavoriteCubit favoriteCubit;

  // Disable Http calls. Needed because the app use Image.network.
  setUpAll(() => HttpOverrides.global = null);

  setUp(() {
    mockRecipe1 = MockRecipe();
    when(() => mockRecipe1.id).thenReturn(recipe1.id);
    when(() => mockRecipe1.name).thenReturn(recipe1.name);
    when(() => mockRecipe1.imageUri).thenReturn(recipe1.imageUri);
    mockRecipe2 = MockRecipe();
    when(() => mockRecipe2.id).thenReturn(recipe2.id);
    when(() => mockRecipe2.name).thenReturn(recipe2.name);
    when(() => mockRecipe2.imageUri).thenReturn(recipe2.imageUri);
    recipesRepository = MockRecipeRepository();
    when(
      () => recipesRepository.searchRecipes(any()),
    ).thenAnswer((_) async => [mockRecipe1, mockRecipe2]);
    recipesCubit = RecipesCubit(recipesRepository);

    favoriteCubit = MockFavoriteCubit();
    when(
      () => favoriteCubit.state,
    ).thenAnswer((_) => FavoriteState(favorites: []));
    when(() => favoriteCubit.isFavorite(recipe1)).thenAnswer((_) => false);
    when(() => favoriteCubit.isFavorite(recipe2)).thenAnswer((_) => false);
  });

  testWidgets('Initial state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipesCubit),
          BlocProvider.value(value: favoriteCubit),
        ],
        child: MaterialApp(home: RecipesPage()),
      ),
    );

    expect(find.text('Starting'), findsOne);
    expect(find.byType(TextField), findsOne);
    expect(find.byIcon(Icons.search), findsOne);
  });

  testWidgets('Can trigger a search request', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipesCubit),
          BlocProvider.value(value: favoriteCubit),
        ],
        child: MaterialApp(home: RecipesPage()),
      ),
    );

    await tester.enterText(find.byType(TextField), 'pasta');
    await tester.tap(find.byIcon(Icons.search));

    await tester.pumpAndSettle();
    expect(find.byType(RecipeCard), findsNWidgets(2));
  });
}
