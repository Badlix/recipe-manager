import 'package:equatable/equatable.dart';
import 'package:recipe_manager/recipe/models/recipe_details.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart' show RecipeRepository;

part 'recipe_details_state.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._repository) : super(RecipeDetailsState());

  final RecipeRepository _repository;

  Future<void> getRecipeDetail(int id) async {
    try {
      emit(state.copyWith(status: RecipeDetailsStatus.loading));
      final recipe = await _repository.getRecipeDetail(id);
      emit(
        state.copyWith(
          status: RecipeDetailsStatus.success,
          recipeDetails: RecipeDetails.fromRepository(recipe),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RecipeDetailsStatus.failure));
    }
  }
}
