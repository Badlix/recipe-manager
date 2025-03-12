// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:spoonacular_api/spoonacular_api.dart' as spoonacular_api;
import 'package:test/test.dart';
import 'package:recipe_repository/recipe_repository.dart';

class MockOpenMeteoApiClient extends Mock
    implements spoonacular_api.SpoonacularApiClient {}

class MockLocation extends Mock implements spoonacular_api.Recipe {}

void main() {
  group('RecipeRepository', () {
    late spoonacular_api.SpoonacularApiClient spoonacularApiClient;
    late RecipeRepository recipeRepository;

    setUp(() {
      spoonacularApiClient = MockOpenMeteoApiClient();
      recipeRepository = RecipeRepository(
        spoonacularApiClient: spoonacularApiClient,
      );
    });

    group('constructor', () {
      test(
        'instantiates internal spoonacular api client when not injected',
        () {
          expect(RecipeRepository(), isNotNull);
        },
      );
    });

    group('getRecipeDetail', () {
      const id = 716429;

      test('calls getRecipeDetail with correct id', () async {
        Recipe recipe = await recipeRepository.getRecipeDetail(id);

        expect(recipe.id, 716429);
        expect(
          recipe.name,
          "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
        );
        expect(
          recipe.imageUri,
          "https://img.spoonacular.com/recipes/716429-556x370.jpg",
        );
      });

      test('throws when getRecipeDetail fails', () async {
        final exception = Exception('oops');
        when(
          () => recipeRepository.getRecipeDetail(any()),
        ).thenThrow(exception);
        expect(
          () async => recipeRepository.getRecipeDetail(id),
          throwsA(exception),
        );
      });
    });

    group('dispose', () {
      test('closes the spoonacular api client', () {
        recipeRepository.dispose();
        verify(spoonacularApiClient.close).called(1);
      });
    });
  });
}
