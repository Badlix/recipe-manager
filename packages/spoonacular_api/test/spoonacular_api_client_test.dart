// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:spoonacular_api/spoonacular_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('SpoonacularApiClient', () {
    late http.Client httpClient;
    late SpoonacularApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = SpoonacularApiClient(httpClient: httpClient);
    });

    group('recipeSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.recipeSearch(query);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('api.spoonacular.com', '/recipes/complexSearch', {
              'apiKey': const String.fromEnvironment('SPOONACULAR_KEY'),
              'query': query,
              'number': '1',
            }),
          ),
        ).called(1);
      });

      test('throws RecipeRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.recipeSearch(query),
          throwsA(isA<RecipeRequestFailure>()),
        );
      });

      test('throws RecipeNotFoundFailure on error response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.recipeSearch(query),
          throwsA(isA<RecipeNotFoundFailure>()),
        );
      });

      test('throws RecipeNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.recipeSearch(query),
          throwsA(isA<RecipeNotFoundFailure>()),
        );
      });

      test('returns Recipe on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
{
  "results": [
    {
      "id": 13,
      "title": "Soupe aux champignons",
      "image": "https://img"
    }
  ]
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.recipeSearch(query);
        expect(
          actual,
          isA<Recipe>()
              .having((l) => l.title, 'title', 'Soupe aux champignons')
              .having((l) => l.id, 'id', 13)
              .having((l) => l.image, 'image', 'https://img'),
        );
      });
    });
  });
}
