// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Recipe', json, ($checkedConvert) {
      final val = Recipe(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        imageUri: $checkedConvert('image_uri', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'imageUri': 'image_uri'});

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image_uri': instance.imageUri,
};
