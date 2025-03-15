import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/favorite_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children:
                state.favorites
                    .map((recipe) => Center(child: Text(recipe.toString())))
                    .toList(),
          );
        },
      ),
    );
  }
}
