part of 'favorite_cubit.dart';

final class FavoriteState extends Equatable {
  FavoriteState({List<Recipe>? favorites}) : favorites = favorites ?? [];

  final List<Recipe> favorites;

  @override
  List<Object?> get props => [favorites];

  FavoriteState copyWith({List<Recipe>? favoriteRecipes}) {
    return FavoriteState(favorites: favoriteRecipes ?? favorites);
  }
}
