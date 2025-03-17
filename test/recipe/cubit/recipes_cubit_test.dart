// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_manager/recipe/models/models.dart';
import 'package:recipe_repository/recipe_repository.dart' as recipe_repository;

class MockRecipesRepository extends Mock
    implements recipe_repository.RecipeRepository {}

class MockRecipe extends Mock implements recipe_repository.Recipe {}

final Recipe recipe1 = Recipe(id: 1, name: 'Carbonara', imageUri: 'https://');

void main() {
  late recipe_repository.Recipe mockRecipe;
  late recipe_repository.RecipeRepository recipesRepository;
  late RecipesCubit recipesCubit;

  setUp(() {
    mockRecipe = MockRecipe();
    when(() => mockRecipe.id).thenReturn(recipe1.id);
    when(() => mockRecipe.name).thenReturn(recipe1.name);
    when(() => mockRecipe.imageUri).thenReturn(recipe1.imageUri);
    recipesRepository = MockRecipesRepository();
    when(
      () => recipesRepository.searchRecipes(any()),
    ).thenAnswer((_) async => [mockRecipe]);
    recipesCubit = RecipesCubit(recipesRepository);
  });

  test('initial state is correct', () {
    expect(recipesCubit.state, RecipesState());
    expect(recipesCubit.state.status.isInitial, true);
  });

  group('Recipes search', () {
    const query = 'pasta';

    blocTest<RecipesCubit, RecipesState>(
      'calls searchRecipes',
      build: () => recipesCubit,
      act: (cubit) => cubit.searchRecipes(query),
      verify: (_) {
        verify(() => recipesRepository.searchRecipes(query)).called(1);
      },
    );

    blocTest<RecipesCubit, RecipesState>(
      'emits [loading, success] when searchRecipes returns',
      build: () => recipesCubit,
      act: (cubit) => cubit.searchRecipes(query),
      expect:
          () => <RecipesState>[
            RecipesState(status: RecipesStatus.loading),
            RecipesState(status: RecipesStatus.success, recipes: [recipe1]),
          ],
    );

    blocTest<RecipesCubit, RecipesState>(
      'emits [loading, failure] when searchRecipes throws',
      setUp: () {
        when(
          () => recipesRepository.searchRecipes(any()),
        ).thenThrow(Exception('searchRecipes failed'));
      },
      build: () => recipesCubit,
      act: (cubit) => cubit.searchRecipes(query),
      expect:
          () => <RecipesState>[
            RecipesState(status: RecipesStatus.loading),
            RecipesState(status: RecipesStatus.failure),
          ],
    );
  });
}
