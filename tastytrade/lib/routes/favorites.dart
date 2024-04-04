import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tastytrade/widgets/recipe.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 16, right: 16),
      child: Column(
        children: [
          const Center(
              child: Text('Favorites',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns here
                crossAxisSpacing: 8.0, // Set the spacing between columns
                mainAxisSpacing: 8.0, // Set the spacing between rows
              ),
              itemCount: 10,
              addAutomaticKeepAlives: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Recipe(
                  large: false,
                  imageLocation: 'assets/breakfast.png',
                  recipeName: 'Recipe Namesssssssssssssssssssssssssss',
                  recipeCreator: 'Recipe Creatorssssssssssssssssss',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
