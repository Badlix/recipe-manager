import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe extends Equatable {
  const Recipe({required this.id, required this.name, required this.imageUri});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  final int id;
  final String name;
  final String imageUri;

  @override
  List<Object> get props => [id, name, imageUri];
}
