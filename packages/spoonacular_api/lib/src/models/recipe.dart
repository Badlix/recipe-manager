import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  const Recipe({required this.id, required this.title, required this.image});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  final int id;
  final String title;
  final String image;
}
