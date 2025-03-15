import 'package:equatable/equatable.dart';
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
      print("ERROR : ${error.toString()}");
      emit(state.copyWith(status: RecipesStatus.failure));
    }
  }
}
