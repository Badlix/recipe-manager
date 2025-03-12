import 'package:equatable/equatable.dart';
import 'package:recipe_manager/recipe/recipe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart' show RecipeRepository;

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this._recipeRepository) : super(RecipesState());

  final RecipeRepository _recipeRepository;

  Future<void> fetchRecipes(String searchText) async {
    emit(state.copyWith(status: RecipesStatus.loading));

    try {
      var searchResult = await _recipeRepository.searchRecipes(searchText);

      List<Recipe> recipes = [];

      for (var recipe in searchResult) {
        recipes.add(Recipe.fromRepository(recipe));
      }

      emit(state.copyWith(status: RecipesStatus.success, recipes: recipes));
    } on Exception {
      emit(state.copyWith(status: RecipesStatus.failure));
    }
  }
}
