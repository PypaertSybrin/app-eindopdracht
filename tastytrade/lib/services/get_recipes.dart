import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';

class GetRecipes with ChangeNotifier {
  final List<RecipeModel> _recipes = [];
  List<RecipeModel> get recipes => _recipes;

  // get all recipes from firebase
  Future<List<RecipeModel>> getAllRecipes() async {
    _recipes.clear();
    await FirebaseFirestore.instance.collection('recipes').get().then((value) {
      for (var element in value.docs) {
        RecipeModel recipe = RecipeModel(
          imageLocation: element['ImageLocation'],
          recipeName: element['RecipeName'],
          createrName: element['CreaterName'],
          createrUid: element['CreaterUid'],
          minutes: element['Minutes'],
          servings: element['Servings'],
          category: element['Category'],
          ingredients: List<String>.from(element['Ingredients']),
          description: element['Description'],
          likes: List<String>.from(element['Likes']),
          date: element['Date'].toDate(),
        );
        _recipes.add(recipe);
      }
    });
    notifyListeners();
    return _recipes;
  }

  // voor recipe list zodat het update in je profile, een string meegeven ipv recipes en dan ifs en dan reads doen

  // get recipes by user id

  // get recipes by category

  // get recipes by liked

  // parameter toevoegen van recepten die je liked
  // of ipv aantal likes bijhouden een list van user id's die het recept hebben geliked

  // void addRecipe(String recipe) {
  //   _recipes.add(recipe);
  //   notifyListeners();
  // }

  // void removeRecipe(String recipe) {
  //   _recipes.remove(recipe);
  //   notifyListeners();
  // }
}
