import 'package:recipe_repository/recipe_repository.dart';

void main() async {
  List<Recipe> recipes = await RecipeRepository().searchRecipes("soupe");

  for (var recipe in recipes) {
    print('${recipe.id} : ${recipe.name} -> ${recipe.imageUri}');
  }

  Recipe recipe = await RecipeRepository().getRecipeDetail(716429);
  print('${recipe.id} : ${recipe.name} -> ${recipe.imageUri}');
}
