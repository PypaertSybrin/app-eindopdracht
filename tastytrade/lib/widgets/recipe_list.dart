import 'package:flutter/material.dart';
import 'package:tastytrade/widgets/recipe.dart';

class RecipeList extends StatelessWidget {

  RecipeList({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 10,
      addAutomaticKeepAlives: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const Recipe(
          large: false,
          imageLocation: 'assets/breakfast.png',
          recipeName: 'Recipe Namesssssssssssssssssssssssssss',
          recipeCreator: 'Recipe Creatorsssssssssssssssssss',
        );
      },
    );
  }
}