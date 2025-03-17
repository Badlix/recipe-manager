import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/models/recipe.dart';
import 'package:recipe_manager/recipe/cubit/favorite_cubit.dart';
import 'package:recipe_manager/recipe/view/recipe_detail_page.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                final recipesRepository =
                    RepositoryProvider.of<repository.RecipeRepository>(context);
                final recipeDetailsCubit = RecipeDetailsCubit(
                  recipesRepository,
                );
                recipeDetailsCubit.getRecipeDetail(recipe.id);
                return BlocProvider(
                  create: (context) => recipeDetailsCubit,
                  child: RecipeDetailPage(recipe: recipe),
                );
              },
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      recipe.imageUri,
                      height: 150,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        final favoritesCubit = context.read<FavoriteCubit>();
                        final isFavorite = favoritesCubit.isFavorite(recipe);
                        return IconButton(
                          onPressed:
                              () async => favoritesCubit.toggleFavorite(recipe),
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
