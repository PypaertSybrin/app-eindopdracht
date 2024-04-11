import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';

class GetRecipes with ChangeNotifier {
  List<String> _recipes = [];
  List<String> get recipes => _recipes;

  // get all recipes from firebase
  Future<List<RecipeModel>> getAllRecipes() async {
    // get all recipes from firebase
    List<RecipeModel> recipes = [];
    await FirebaseFirestore.instance.collection('recipes').get().then((value) {
      value.docs.forEach((element) {
        RecipeModel recipe = RecipeModel(
          imageLocation: element['Image_Location'],
          recipeName: element['Recipe_Name'],
          createrName: element['Creater_Name'],
          createrUid: element['Creater_Uid'],
          minutes: element['Minutes'],
          servings: element['Servings'],
          category: element['Category'],
          ingredients: List<String>.from(element['Ingredients']),
          description: element['Description'],
          likes: element['Likes'],
          views: element['Views'],
          date: element['Date'].toDate(),
        );
        recipes.add(recipe);
      });
    });
    print(recipes.length);
    return recipes;
  }

  // get recipes by user id

  // get recipes by category

  // get recipes by liked

  // parameter toevoegen van recepten die je liked 
  // of ipv aantal likes bijhouden een list van user id's die het recept hebben geliked

  void addRecipe(String recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(String recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }
}
