import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/recipe_list.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: const Color(0xFFFF8737),
        onRefresh: () async {
          await context.read<GetRecipes>().getAllRecipes();
        },
        child: RecipeList(recipes: context.watch<GetRecipes>().likedRecipes));
  }
}
