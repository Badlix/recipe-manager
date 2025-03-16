import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/view/recipe_card.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipesPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Rechercher une recette",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  context.read<RecipesCubit>().searchRecipes(
                    _textController.text,
                  );
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
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
    );
  }
}
