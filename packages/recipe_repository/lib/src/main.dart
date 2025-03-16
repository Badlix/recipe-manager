import 'package:recipe_repository/recipe_repository.dart';

void main() async {
  // List<Recipe> recipes = await RecipeRepository().searchRecipes("soupe");

  // for (var recipe in recipes) {
  //   print('${recipe.id} : ${recipe.name} -> ${recipe.imageUri}');
  // }

  RecipeDetails recipe = await RecipeRepository().getRecipeDetail(716429);
  print('ID :${recipe.id}');
  print('Name : ${recipe.name}');
  print('Photo : ${recipe.imageUri}');
  print('Ingrédients :');
  for (var element in recipe.ingredients) {
    print(' - ${element}');
  }
  print('Étapes :');
  for (var element in recipe.steps) {
    print(' - ${element}');
  }
}
