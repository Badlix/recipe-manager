import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart'
    show FavoriteRepository;

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._favoriteRepository) : super(FavoriteState());

  final FavoriteRepository _favoriteRepository;

  Future<void> _addFavorite(int id) async {
    await _favoriteRepository.addFavorite(id);
    final favorites = await _favoriteRepository.getFavorites();
    emit(state.copyWith(favoriteRecipesIds: [...favorites]));
  }

  Future<void> _removeFavorite(int recipeId) async {
    await _favoriteRepository.removeFavorite(recipeId);
    final favorites = await _favoriteRepository.getFavorites();
    emit(state.copyWith(favoriteRecipesIds: [...favorites]));
  }

  bool isFavorite(int id) {
    return state.favorites.contains(id);
  }

  void toggleFavorite(int id) async {
    if (isFavorite(id)) {
      await _removeFavorite(id);
    } else {
      await _addFavorite(id);
    }
  }
}
