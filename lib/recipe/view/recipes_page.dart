import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecipesCubit, RecipesState>(
        builder: (context, state) {
          return switch (state.status) {
            RecipesStatus.initial => const Center(child: Text('Starting')),
            RecipesStatus.loading => const Center(child: Text('Loading')),
            RecipesStatus.failure => const Center(child: Text('Failure')),
            RecipesStatus.success => ListView(
              children:
                  state.recipes.map((recipe) => Text(recipe.name)).toList(),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<RecipesCubit>().fetchRecipes('soup');
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
