import 'package:equatable/equatable.dart';
import 'package:recipe_manager/recipe/models/recipe_details.dart';
import 'package:recipe_manager/recipe/recipe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart' show RecipeRepository;

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this._repository) : super(RecipesState());

  final RecipeRepository _repository;

  Future<void> searchRecipes(String query) async {
    try {
      emit(state.copyWith(status: RecipesStatus.loading));

      final recipes = await _repository.searchRecipes(query);
      emit(
        state.copyWith(
          status: RecipesStatus.success,
          recipes:
              recipes.map((recipe) => Recipe.fromRepository(recipe)).toList(),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RecipesStatus.failure));
    }
  }

  Future<void> getRecipeDetail(int id) async {
    try {
      emit(state.copyWith(status: RecipesStatus.loading));
      final recipe = await _repository.getRecipeDetail(id);
      emit(
        state.copyWith(
          status: RecipesStatus.success,
          recipeDetails: RecipeDetails.fromRepository(recipe),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RecipesStatus.failure));
    }
  }
}
