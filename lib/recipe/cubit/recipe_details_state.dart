part of 'recipe_details_cubit.dart';

enum RecipeDetailsStatus { initial, loading, success, failure }

extension RecipeDetailsStatusX on RecipeDetailsStatus {
  bool get isInitial => this == RecipeDetailsStatus.initial;
  bool get isLoading => this == RecipeDetailsStatus.loading;
  bool get isSuccess => this == RecipeDetailsStatus.success;
  bool get isFailure => this == RecipeDetailsStatus.failure;
}

final class RecipeDetailsState extends Equatable {
  RecipeDetailsState({
    this.status = RecipeDetailsStatus.initial,
    RecipeDetails? recipeDetails,
  }) : recipeDetails = recipeDetails ?? RecipeDetails.emptyInstance();

  final RecipeDetailsStatus status;
  final RecipeDetails recipeDetails;

  RecipeDetailsState copyWith({
    RecipeDetailsStatus? status,
    RecipeDetails? recipeDetails,
  }) {
    return RecipeDetailsState(
      status: status ?? this.status,
      recipeDetails: recipeDetails ?? this.recipeDetails,
    );
  }

  @override
  List<Object?> get props => [status, recipeDetails];
}
