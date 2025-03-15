import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recipe_manager/recipe/recipe.dart';
import 'package:recipe_repository/recipe_repository.dart'
    show FavoriteRepository;

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._favoriteRepository) : super(FavoriteState());

  final FavoriteRepository _favoriteRepository;

  Future<void> _addFavorite(Recipe recipe) async {
    await _favoriteRepository.addFavorite(recipe.toRepository());
    final favorites = await _favoriteRepository.getFavorites();
    emit(
      state.copyWith(
        favoriteRecipes: [
          ...favorites.map((recipe) => Recipe.fromRepository(recipe)),
        ],
      ),
    );
  }

  Future<void> _removeFavorite(Recipe recipe) async {
    await _favoriteRepository.removeFavorite(recipe.toRepository());
    final favorites = await _favoriteRepository.getFavorites();
    emit(
      state.copyWith(
        favoriteRecipes: [
          ...favorites.map((recipe) => Recipe.fromRepository(recipe)),
        ],
      ),
    );
  }

  bool isFavorite(Recipe recipe) {
    return state.favorites.contains(recipe);
  }

  void toggleFavorite(Recipe recipe) async {
    if (isFavorite(recipe)) {
      await _removeFavorite(recipe);
    } else {
      await _addFavorite(recipe);
    }
  }
}
