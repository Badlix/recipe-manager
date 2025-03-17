import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipe_details_cubit.dart';
import 'package:recipe_manager/recipe/models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
        builder: (context, state) {
          return switch (state.status) {
            RecipeDetailsStatus.initial => const Center(
              child: Text('Starting'),
            ),
            RecipeDetailsStatus.loading => const Center(child: Text('Loading')),
            RecipeDetailsStatus.failure => const Center(child: Text('Failure')),
            RecipeDetailsStatus.success => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe image
                    Image.network(
                      state.recipeDetails.imageUri,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(height: 15),

                    // Recipe name
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        state.recipeDetails.name,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            state.recipeDetails.ingredients
                                .map((ingredient) => Text(" - $ingredient"))
                                .toList(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// Recipe steps
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            state.recipeDetails.steps
                                .map((step) => Text(step))
                                .toList(),
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
