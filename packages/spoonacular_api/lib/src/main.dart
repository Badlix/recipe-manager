import "package:spoonacular_api/src/models/recipe_details.dart";
import "package:spoonacular_api/src/spoonacular_api_client.dart";

void main() async {
  RecipeDetails recipe = await SpoonacularApiClient().getRecipeDetail(716429);

  print('ID :${recipe.id}');
  print('Name : ${recipe.title}');
  print('Photo : ${recipe.image}');
  print('Ingrédients :');
  for (var element in recipe.extendedIngredients) {
    print(' - ${element}');
  }
  print('Étapes :');
  for (var element in recipe.analyzedInstructions) {
    print(' - ${element}');
  }
}
