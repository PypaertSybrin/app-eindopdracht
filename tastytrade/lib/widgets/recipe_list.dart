import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/recipe.dart';

class RecipeList extends StatelessWidget {
  List<RecipeModel> recipes;
  RecipeList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    // print("recipes length in favorites and profile: ${recipes.length}");
    return recipes.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: recipes.length,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Recipe(
                large: false,
                recipe: recipe,
              );
            },
          )
        : const Center(
            child: Text('No recipes found'),
          );
  }
}
