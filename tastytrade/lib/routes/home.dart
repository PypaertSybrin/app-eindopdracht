import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/routes/filter.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/category.dart';
import 'package:tastytrade/widgets/recipe.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final popularRecipes = context.watch<GetRecipes>().top5ByLikes;
    final newRecipes = context.watch<GetRecipes>().top5ByDate;
    return RefreshIndicator(
      color: const Color(0xFFFF8737),
      onRefresh: () async {
        await context.read<GetRecipes>().getAllRecipes();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Title(title: 'Categories'),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Title(title: 'Popular Recipes'),
                  TextButton(
                    onPressed: () {
                      context
                          .read<GetRecipes>()
                          .sortRecipesByPopularityOrDate(true);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Filter(
                            filter: 'Popular Recipes', isCategory: false);
                      }));
                    },
                    child: const Text(
                      'View all',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // if first item, add padding to the left
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Recipe(
                          large: true,
                          recipe: popularRecipes[index],
                        ),
                      );
                    }
                    // if last item, add padding to the right
                    if (index == 4) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Recipe(
                          large: true,
                          recipe: popularRecipes[index],
                        ),
                      );
                    }
                    // for other items
                    return Recipe(
                      large: true,
                      recipe: popularRecipes[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Title(title: 'New Recipes'),
                  TextButton(
                    onPressed: () {
                      context
                          .read<GetRecipes>()
                          .sortRecipesByPopularityOrDate(false);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Filter(filter: 'New Recipes', isCategory: false);
                      }));
                    },
                    child: const Text('View all',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // if first item, add padding to the left
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Recipe(
                          large: true,
                          recipe: newRecipes[index],
                        ),
                      );
                    }
                    // if last item, add padding to the right
                    if (index == 4) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Recipe(
                          large: true,
                          recipe: newRecipes[index],
                        ),
                      );
                    }
                    // for other items
                    return Recipe(
                      large: true,
                      recipe: newRecipes[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: title == 'Categories' ? 0 : 24, bottom: 8, left: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
