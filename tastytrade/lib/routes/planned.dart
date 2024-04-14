import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/recipe_planned.dart';

class Planned extends StatelessWidget {
  const Planned({super.key});
  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<GetRecipes>().shoppingLists;
    return recipes.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: recipes.length,
              clipBehavior: Clip.none,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                return RecipePlanned(
                  recipe: recipes[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            ),
          )
        : const Center(
            child: Text('No recipes found'),
          );
  }
}
