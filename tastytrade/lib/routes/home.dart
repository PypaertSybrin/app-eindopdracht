import 'package:flutter/material.dart';
import 'package:tastytrade/widgets/category.dart';
import 'package:tastytrade/widgets/recipe.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
            const Title(title: 'Categories'),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Category('assets/breakfast.png', 'Breakfast'),
                  Category('assets/lunch.png', 'Lunch'),
                  Category('assets/dinner.png', 'Dinner'),
                  Category('assets/dessert.png', 'Dessert'),
                ],
              ),
            ),
            const Title(title: 'Popular Recipes'),
            SizedBox(
              height: 190,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  // if first item, add padding to the left
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Recipe(
                          large: true,
                          imageLocation: 'assets/breakfast.png',
                          recipeName: 'Recipe Namesssssssssssssssssssssssss',
                          recipeCreator: 'Recipe Creatorsssssssssssssssssssss'),
                    );
                  }
                  // if last item, add padding to the right
                  if (index == 4) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Recipe(
                          large: true,
                          imageLocation: 'assets/breakfast.png',
                          recipeName: 'Recipe Name',
                          recipeCreator: 'Recipe Creator'),
                    );
                  }
                  return const Recipe(
                      large: true,
                      imageLocation: 'assets/breakfast.png',
                      recipeName: 'Recipe Name',
                      recipeCreator: 'Recipe Creator');
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
              ),
            ),
            const Title(title: 'New Recipes'),
            SizedBox(
              height: 190,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  // if first item, add padding to the left
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Recipe(
                          large: true,
                          imageLocation: 'assets/breakfast.png',
                          recipeName: 'Recipe Name',
                          recipeCreator: 'Recipe Creator'),
                    );
                  }
                  // if last item, add padding to the right
                  if (index == 4) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Recipe(
                          large: true,
                          imageLocation: 'assets/breakfast.png',
                          recipeName: 'Recipe Name',
                          recipeCreator: 'Recipe Creator'),
                    );
                  }
                  return const Recipe(
                      large: true,
                      imageLocation: 'assets/breakfast.png',
                      recipeName: 'Recipe Name',
                      recipeCreator: 'Recipe Creator');
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
