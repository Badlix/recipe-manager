import 'package:spoonacular_api/spoonacular_api.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe', () {
    group('fromJson', () {
      test('returns correct Recipe object', () {
        expect(
          Recipe.fromJson(<String, dynamic>{
            'id': 13,
            'title': 'Soupe aux champignons',
            'image': 'https:img/une_image',
          }),
          isA<Recipe>()
              .having((r) => r.id, 'id', 13)
              .having((r) => r.title, 'title', 'Soupe aux champignons')
              .having((r) => r.image, 'image', 'https:img/une_image'),
        );
      });
    });
  });
}
