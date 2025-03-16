import 'package:json_annotation/json_annotation.dart';

part 'recipe_details.g.dart';

@JsonSerializable()
class RecipeDetails {
  const RecipeDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.extendedIngredients,
    required this.analyzedInstructions,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsFromJson(json);

  final int id;
  final String title;
  final String image;
  final List<String> extendedIngredients;
  final List<String> analyzedInstructions;

  // Helper method to extract and format ingredients
  static List<String> _extractIngredients(List<dynamic> ingredientsJson) {
    List<String> ingredientList = [];
    for (var ingredient in ingredientsJson) {
      ingredientList.add(ingredient['original']);
    }

    return ingredientList;
  }

  // Helper method to extract and format steps (number + step)
  static List<String> _extractAnalyzedInstructions(
    List<dynamic> instructionsJson,
  ) {
    List<String> stepsList = [];
    for (var instruction in instructionsJson) {
      var steps = instruction['steps'] as List<dynamic>;
      for (var step in steps) {
        var stepNumber = step['number'] as int;
        var stepText = step['step'] as String;
        stepsList.add('$stepNumber. $stepText');
      }
    }
    return stepsList;
  }
}
