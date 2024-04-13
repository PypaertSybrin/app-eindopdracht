import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';

class GetRecipes with ChangeNotifier {
  final List<RecipeModel> _recipes = [];
  final List<RecipeModel> _userRecipes = [];
  final List<RecipeModel> _likedRecipes = [];
  List<RecipeModel> get recipes => _recipes;
  List<RecipeModel> get userRecipes => _userRecipes;
  List<RecipeModel> get likedRecipes => _likedRecipes;

  // get all recipes from firebase
  Future<List<RecipeModel>> getAllRecipes() async {
    // local variable is for when one user fetches recipes, others can still use the filters
    List<RecipeModel> newListRecipes = [];
    await FirebaseFirestore.instance.collection('recipes').get().then((value) {
      for (var element in value.docs) {
        RecipeModel recipe = RecipeModel(
          docId: element['DocId'],
          imageLocation: element['ImageLocation'],
          recipeName: element['RecipeName'],
          createrName: element['CreaterName'],
          createrUid: element['CreaterUid'],
          createrProfilePicture: element['CreaterProfilePicture'],
          minutes: element['Minutes'],
          servings: element['Servings'],
          category: element['Category'],
          ingredients: List<String>.from(element['Ingredients']),
          description: element['Description'],
          likes: List<String>.from(element['Likes']),
          date: element['Date'].toDate(),
        );
        newListRecipes.add(recipe);
      }
    });
    _recipes.clear();
    _recipes.addAll(newListRecipes);
    notifyListeners();
    return _recipes;
  }

  // get recipes by user
  List<RecipeModel> getRecipesByUser(String uid) {
    List<RecipeModel> userRecipes = [];
    for (var recipe in _recipes) {
      if (recipe.createrUid == uid) {
        userRecipes.add(recipe);
      }
    }
    _userRecipes.clear();
    _userRecipes.addAll(userRecipes);
    notifyListeners();
    return _userRecipes;
  }

  // get recipes you liked
  List<RecipeModel> getRecipesByLiked(String uid) {
    List<RecipeModel> likedRecipes = [];
    for (var recipe in _recipes) {
      if (recipe.likes.contains(uid)) {
        likedRecipes.add(recipe);
      }
    }
    _likedRecipes.clear();
    _likedRecipes.addAll(likedRecipes);
    notifyListeners();
    return likedRecipes;
  }

  // add a recipe
  Future addRecipe(RecipeModel recipe) async {
    final newRecipe =
        await FirebaseFirestore.instance.collection('recipes').add({
      'DocId': recipe.docId,
      'ImageLocation': recipe.imageLocation,
      'RecipeName': recipe.recipeName,
      'CreaterName': recipe.createrName,
      'CreaterUid': recipe.createrUid,
      'CreaterProfilePicture': recipe.createrProfilePicture,
      'Minutes': recipe.minutes,
      'Servings': recipe.servings,
      'Category': recipe.category,
      'Ingredients': recipe.ingredients,
      'Description': recipe.description,
      'Likes': recipe.likes,
      'Date': recipe.date,
    }).then((DocumentReference doc) => {
              doc.update({'DocId': doc.id}),
              recipe.docId = doc.id,
            });
    // get new recipe from firebase so that the local recipe also has the docId
    _recipes.add(recipe);
    getRecipesByUser(recipe.createrUid);
    notifyListeners();
  }


  // update a recipe
  // Future updateRecipe(RecipeModel recipe) async {
  //   await FirebaseFirestore.instance
  //       .collection('recipes')
  //       .doc(recipe.docId)
  //       .update({
  //     'ImageLocation': recipe.imageLocation,
  //     'RecipeName': recipe.recipeName,
  //     'CreaterName': recipe.createrName,
  //     'CreaterUid': recipe.createrUid,
  //     'CreaterProfilePicture': recipe.createrProfilePicture,
  //     'Minutes': recipe.minutes,
  //     'Servings': recipe.servings,
  //     'Category': recipe.category,
  //     'Ingredients': recipe.ingredients,
  //     'Description': recipe.description,
  //     'Likes': recipe.likes,
  //     'Date': recipe.date,
  //   });
  //   notifyListeners();
  // }

  // update a recipe
  Future updateRecipeLikes(RecipeModel recipe) async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipe.docId)
        .update({
      'Likes': recipe.likes,
    });
    notifyListeners();
  }

  // add or remove like
  Future addOrRemoveLike(String docId, String uid) async {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    if (checkIfLiked(docId, uid)) {
      recipe.likes.remove(uid);
    } else {
      recipe.likes.add(uid);
    }
    // check if you liked the recipe to update the like button
    checkIfLiked(docId, uid);
    // recepten ophalen die je geliked hebt om je favorites te updaten
    getRecipesByLiked(uid);
    // update recipe in firebase
    await updateRecipeLikes(recipe);
    notifyListeners();
  }

  // get likes of a recipe
  int getLikes(String docId) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    return recipe.likes.length;
  }

  // check if user liked a recipe to update the like button
  bool checkIfLiked(String docId, String uid) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    return recipe.likes.contains(uid);
  }

  // KOMENDE DINGEN EERST TE DOEN
  // recepten ophalen per user, met watch zoals in favorites zal hij automatisch kunnen updaten, gewoon bij aanmaken de lijst opnieuw opvragen (denk ik)

  // wanneer je op recept detail klikt, ook de likes ophalen en dan checken of je het geliked hebt of niet

  // voor recipe list zodat het update in je profile, een string meegeven ipv recipes en dan ifs en dan reads doen

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
