import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/widgets/recipe.dart';

class RecipeList extends StatelessWidget {
  final List<RecipeModel> recipes;
  const RecipeList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return recipes.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: MediaQuery.of(context).size.width / 2 / 200,
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
