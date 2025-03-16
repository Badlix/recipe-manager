import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_manager/recipe/cubit/recipe_details_cubit.dart';
import 'package:recipe_manager/recipe/cubit/recipes_cubit.dart';
import 'package:recipe_manager/recipe/cubit/favorite_cubit.dart';
import 'package:recipe_manager/recipe/view/favorites_page.dart';
import 'package:recipe_manager/recipe/view/recipes_page.dart';
import 'package:recipe_repository/recipe_repository.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({
    super.key,
    required this.recipesRepository,
    required this.favoritesRepository,
  });
  final RecipeRepository recipesRepository;
  final FavoriteRepository favoritesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RecipeRepository>(
          create: (context) => recipesRepository,
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<FavoriteRepository>(
          create: (context) => favoritesRepository,
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RecipesCubit(recipesRepository)),
          BlocProvider(
            create:
                (context) => FavoriteCubit(
                  favoritesRepository,
                  favoritesRepository.favorites,
                ),
          ),
          BlocProvider(
            create: (context) => RecipeDetailsCubit(recipesRepository),
          ),
        ],
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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.dinner_dining)),
                Tab(icon: Icon(Icons.favorite_border)),
              ],
            ),
          ),
          body: const TabBarView(children: [RecipesPage(), FavoritesPage()]),
        ),
      ),
    );
  }
}
