import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_repository/recipe_repository.dart' as recipe_repository;

part 'recipe_details.g.dart';

@JsonSerializable()
class RecipeDetails extends Equatable {
  const RecipeDetails({
    required this.id,
    required this.name,
    required this.imageUri,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsFromJson(json);

  factory RecipeDetails.fromRepository(recipe_repository.RecipeDetails recipe) {
    return RecipeDetails(
      id: recipe.id,
      name: recipe.name,
      imageUri: recipe.imageUri,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
    );
  }

  static RecipeDetails emptyInstance() {
    return RecipeDetails(
      id: -1,
      name: '',
      imageUri: '',
      ingredients: [],
      steps: [],
    );
  }

  final int id;
  final String name;
  final String imageUri;
  final List<String> ingredients;
  final List<String> steps;

  @override
  List<Object> get props => [id, name, imageUri, ingredients, steps];

  Map<String, dynamic> toJson() => _$RecipeDetailsToJson(this);

  RecipeDetails copyWith({
    int? id,
    String? name,
    String? imageUri,
    List<String>? ingredients,
    List<String>? steps,
  }) {
    return RecipeDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUri: imageUri ?? this.imageUri,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }

  recipe_repository.RecipeDetails toRepository() {
    return recipe_repository.RecipeDetails(
      id: id,
      name: name,
      imageUri: imageUri,
      ingredients: ingredients,
      steps: steps,
    );
  }
}
