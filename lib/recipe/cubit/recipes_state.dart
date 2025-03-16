part of 'recipes_cubit.dart';

enum RecipesStatus { initial, loading, success, failure }

extension RecipeStatusX on RecipesStatus {
  bool get isInitial => this == RecipesStatus.initial;
  bool get isLoading => this == RecipesStatus.loading;
  bool get isSuccess => this == RecipesStatus.success;
  bool get isFailure => this == RecipesStatus.failure;
}

final class RecipesState extends Equatable {
  RecipesState({
    this.status = RecipesStatus.initial,
    List<Recipe>? recipes,
    RecipeDetails? recipeDetails,
  }) : recipes = recipes ?? [],
       recipeDetails = recipeDetails ?? RecipeDetails.emptyInstance();

  final RecipesStatus status;
  final List<Recipe> recipes;
  final RecipeDetails recipeDetails;

  RecipesState copyWith({
    RecipesStatus? status,
    List<Recipe>? recipes,
    RecipeDetails? recipeDetails,
  }) {
    return RecipesState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      recipeDetails: recipeDetails ?? this.recipeDetails,
    );
  }

  @override
  List<Object?> get props => [status, recipes, recipeDetails];
}
