import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_repository/recipe_repository.dart' as recipe_repository;

part 'recipe.g.dart';

@JsonSerializable()
class Recipe extends Equatable {
  const Recipe({required this.id, required this.name, required this.imageUri});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  factory Recipe.fromRepository(recipe_repository.Recipe recipe) {
    return Recipe(id: recipe.id, name: recipe.name, imageUri: recipe.imageUri);
  }

  final int id;
  final String name;
  final String imageUri;

  @override
  List<Object> get props => [id, name, imageUri];

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  Recipe copyWith({int? id, String? name, String? imageUri}) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUri: imageUri ?? this.imageUri,
    );
  }
}
