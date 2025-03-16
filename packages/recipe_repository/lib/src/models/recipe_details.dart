import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Map<String, dynamic> toJson() => _$RecipeDetailsToJson(this);

  final int id;
  final String name;
  final String imageUri;
  final List<String> ingredients;
  final List<String> steps;

  @override
  List<Object> get props => [id, name, imageUri, ingredients, steps];
}
