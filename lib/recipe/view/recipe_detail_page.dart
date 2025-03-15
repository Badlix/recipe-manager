import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/models/recipe.dart';
import 'package:recipe_manager/recipe/view/recipe_card.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: BlocBuilder<RecipesCubit, RecipesState>(
        builder: (context, state) {
          return switch (state.status) {
            RecipesStatus.initial => const Center(child: Text('Starting')),
            RecipesStatus.loading => const Center(child: Text('Loading')),
            RecipesStatus.failure => const Center(child: Text('Failure')),
            RecipesStatus.success => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe image
                    Image.network(
                      recipe.imageUri,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(height: 15),

                    // Recipe name
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Recipe ingredients
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Ingrédients",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    /// Recipe step
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Étapes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          };
        },
      ),
    );
  }
}
