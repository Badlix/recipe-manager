// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetails _$RecipeDetailsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RecipeDetails', json, ($checkedConvert) {
      final val = RecipeDetails(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        imageUri: $checkedConvert('image_uri', (v) => v as String),
        ingredients: $checkedConvert(
          'ingredients',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        steps: $checkedConvert(
          'steps',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'imageUri': 'image_uri'});

Map<String, dynamic> _$RecipeDetailsToJson(RecipeDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_uri': instance.imageUri,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
    };
