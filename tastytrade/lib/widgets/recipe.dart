import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/routes/recipe_detail.dart';
import 'package:tastytrade/services/get_recipes.dart';

class Recipe extends StatelessWidget {
  final RecipeModel recipe;
  final bool large;

  Recipe({super.key, required this.recipe, required this.large});

  final User? user = FirebaseAuth.instance.currentUser;


  // void addOrRemoveLike(BuildContext context) {
  //   if (context.read<GetRecipes>().checkIfLiked(recipe.docId, recipe.createrUid)) {
  //     removeLike(context);
  //   } else {
  //     addLike(context);
  //   }
  // }
  Future<void> addLike(BuildContext context) async {
    await context.read<GetRecipes>().addLike(recipe.docId, user!.uid);
  }

  Future<void> removeLike(BuildContext context) async {
    await context
        .read<GetRecipes>()
        .removeLike(recipe.docId, user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // volgens mij is large niet nodig
      width: large ? MediaQuery.of(context).size.width * 0.6 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.30),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetail(recipe: recipe)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: large ? 100 : 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(recipe.imageLocation, fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(recipe.recipeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text(recipe.createrName,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey[700])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<GetRecipes>().checkIfLiked(recipe.docId, user!.uid)
                          ? removeLike(context)
                          : addLike(context);
                    },
                    child: Icon(
                      context
                              .watch<GetRecipes>()
                              .checkIfLiked(recipe.docId, user!.uid)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Color(0xFFFF8737),
                      size: 20.0,
                    ),
                  ),
                  Text(context
                      .watch<GetRecipes>()
                      .getLikes(recipe.docId)
                      .toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
