part of 'favorite_cubit.dart';

final class FavoriteState extends Equatable {
  FavoriteState({List<int>? favorites}) : favorites = favorites ?? [];

  final List<int> favorites;

  @override
  List<Object?> get props => [favorites];

  FavoriteState copyWith({List<int>? favoriteRecipesIds}) {
    return FavoriteState(favorites: favoriteRecipesIds ?? favorites);
  }
}
