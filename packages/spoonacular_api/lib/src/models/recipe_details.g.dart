// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'recipe_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetails _$RecipeDetailsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RecipeDetails',
      json,
      ($checkedConvert) {
        final val = RecipeDetails(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          title: $checkedConvert('title', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          extendedIngredients: RecipeDetails._extractIngredients(
            $checkedConvert(
              'extendedIngredients',
              (v) => (v as List<dynamic>).map((e) => e).toList(),
            ),
          ),
          analyzedInstructions: RecipeDetails._extractAnalyzedInstructions(
            $checkedConvert(
              'analyzedInstructions',
              (v) => (v as List<dynamic>).map((e) => e).toList(),
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'extendedIngredients': 'extended_ingredients',
        'analyzedInstructions': 'analyzed_instructions',
      },
    );
