import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/view/recipe_card.dart';

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
              padding: EdgeInsets.symmetric(vertical: 10),
              children:
                  state.recipes
                      .map(
                        (recipe) => Center(child: RecipeCard(recipe: recipe)),
                      )
                      .toList(),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<RecipesCubit>().searchRecipes('pie');
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
