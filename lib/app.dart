import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/view/recipes_page.dart';
import 'package:recipe_repository/recipe_repository.dart' show RecipeRepository;

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => RecipeRepository(),
      dispose: (repository) => repository.dispose(),
      child: BlocProvider(
        create: (context) => RecipesCubit(context.read<RecipeRepository>()),
        child: const RecipeAppView(),
      ),
    );
  }
}

class RecipeAppView extends StatelessWidget {
  const RecipeAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const RecipesPage(),
    );
  }
}
