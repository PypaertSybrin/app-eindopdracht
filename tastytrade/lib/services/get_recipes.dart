import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/utils/local_notification_service.dart';

class GetRecipes with ChangeNotifier {
  // alle recipes
  final List<RecipeModel> _recipes = [];
  // recipes van de huidige user
  final List<RecipeModel> _userRecipes = [];
  // recipes die je geliked hebt
  final List<RecipeModel> _likedRecipes = [];
  // recipes die je als meal plan hebt
  final List<RecipeModel> _shoppingLists = [];
  // recipes die je wilt filteren in filtered screen
  final List<RecipeModel> _filteredList = [];
  // recipes gefilterd op likes in home screen
  final List<RecipeModel> _top5ByLikes = [];
  // recipes gefilterd op datum in home screen
  final List<RecipeModel> _top5ByDate = [];
  List<RecipeModel> get recipes => _recipes;
  List<RecipeModel> get userRecipes => _userRecipes;
  List<RecipeModel> get likedRecipes => _likedRecipes;
  List<RecipeModel> get shoppingLists => _shoppingLists;
  List<RecipeModel> get filteredList => _filteredList;
  List<RecipeModel> get top5ByLikes => _top5ByLikes;
  List<RecipeModel> get top5ByDate => _top5ByDate;

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
          shoppingLists:
              List<Map<String, dynamic>>.from(element['ShoppingLists']),
          date: element['Date'].toDate(),
        );
        newListRecipes.add(recipe);
      }
    });
    _recipes.clear();
    _recipes.addAll(newListRecipes);
    top5RecipesByLikes();
    top5RecipesByDate();
    notifyListeners();
    return _recipes;
  }

  // get recipes by user
  void updateRecipesByUser(String uid) {
    List<RecipeModel> userRecipes = [];
    for (var recipe in _recipes) {
      if (recipe.createrUid == uid) {
        userRecipes.add(recipe);
      }
    }
    _userRecipes.clear();
    _userRecipes.addAll(userRecipes);
    notifyListeners();
  }

  // get recipes you liked
  void updateRecipesByLiked(String uid) {
    List<RecipeModel> likedRecipes = [];
    for (var recipe in _recipes) {
      if (recipe.likes.contains(uid)) {
        likedRecipes.add(recipe);
      }
    }
    _likedRecipes.clear();
    _likedRecipes.addAll(likedRecipes);
    notifyListeners();
  }

  // get meal plans by user
  void updateShoppingListsPerUser(String uid) {
    List<RecipeModel> shoppingList = [];
    for (var recipe in _recipes) {
      for (var list in recipe.shoppingLists) {
        if (list['UserUid'] == uid) {
          try {
            DateTime date = list['Date'];
            DateTime currentDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            DateTime dateToCheck = DateTime(date.year, date.month, date.day);
            // check if the day of the date is in the past, if so delete the meal plan
            if (currentDate.isBefore(dateToCheck) || currentDate.isAtSameMomentAs(dateToCheck)) {
              shoppingList.add(recipe);
            } else {
              deleteMealPlan(recipe.docId, uid);
            }
          } catch (e) {
            DateTime date = convertToDate(list['Date']);
            DateTime currentDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            DateTime dateToCheck = DateTime(date.year, date.month, date.day);
            // check if the date is in the past, if so delete the meal plan
            if (currentDate.isBefore(dateToCheck) || currentDate.isAtSameMomentAs(dateToCheck)) {
              shoppingList.add(recipe);
            } else {
              deleteMealPlan(recipe.docId, uid);
            }
          }
        }
      }
    }
    _shoppingLists.clear();
    _shoppingLists.addAll(shoppingList);
    notifyListeners();
  }

  // sort recipes by date descending
  void top5RecipesByDate() {
    List<RecipeModel> sortedList = List.from(_recipes);
    sortedList.sort((a, b) => b.date.compareTo(a.date));
    _top5ByDate.clear();
    _top5ByDate.addAll(sortedList);
    notifyListeners();
  }

  // sort recipes by likes
  void top5RecipesByLikes() {
    List<RecipeModel> sortedList = List.from(_recipes);
    sortedList.sort((a, b) => b.likes.length.compareTo(a.likes.length));
    _top5ByLikes.clear();
    _top5ByLikes.addAll(sortedList);
    notifyListeners();
  }

  // get total likes of recipes by user
  int getTotalLikes(String uid) {
    int totalLikes = 0;
    for (var recipe in _recipes) {
      if (recipe.createrUid == uid) {
        totalLikes += recipe.likes.length;
      }
    }
    return totalLikes;
  }

  // sort recipes by popularity or date
  void sortRecipesByPopularityOrDate(bool popular) {
    List<RecipeModel> sortedList = List.from(_recipes);
    if (popular) {
      sortedList.sort((a, b) => b.likes.length.compareTo(a.likes.length));
    } else {
      sortedList.sort((a, b) => b.date.compareTo(a.date));
    }
    _filteredList.clear();
    _filteredList.addAll(sortedList);
    notifyListeners();
  }

  // sort recipes by category and on date or likes
  void sortRecipesByCategoryAndDate(String category, bool popular) {
    List<RecipeModel> filteredList = [];
    for (var recipe in _recipes) {
      if (recipe.category == category) {
        filteredList.add(recipe);
      }
    }
    if (popular) {
      filteredList.sort((a, b) => b.likes.length.compareTo(a.likes.length));
    } else {
      filteredList.sort((a, b) => b.date.compareTo(a.date));
    }
    _filteredList.clear();
    _filteredList.addAll(filteredList);
    notifyListeners();
  }

  // add a recipe
  Future addRecipe(RecipeModel recipe) async {
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
      'ShoppingLists': recipe.shoppingLists,
      'Date': recipe.date,
    }).then((DocumentReference doc) => {
          doc.update({'DocId': doc.id}),
          recipe.docId = doc.id,
        });
    // get new recipe from firebase so that the local recipe also has the docId
    _recipes.add(recipe);
    updateRecipesByUser(recipe.createrUid);
    top5RecipesByDate();
    notifyListeners();
  }

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
    updateRecipesByLiked(uid);
    // home screen updaten
    top5RecipesByLikes();
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

  // check if user already has a shoppinglist for that recipe, if not add one, if(true) only update the date
  Future createShoppingList(String docId, String uid, DateTime date) async {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    int notificationId = await LocalNotificationService().showTimedNotification(
        'Ingredients required',
        'Make sure you have all the ingredients for meal \'${recipe.recipeName}\' on ${date.day}/${date.month}/${date.year}');
    recipe.shoppingLists.add({
      'UserUid': uid,
      'Date': date,
      'List': recipe.ingredients,
      'NotificationId': notificationId
    });
    updateShoppingListsPerUser(uid);
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(docId)
        .update({'ShoppingLists': recipe.shoppingLists});
  }

  // get date of a shopping list
  DateTime getDateOfShoppingList(String docId, String uid) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    final shoppingList =
        recipe.shoppingLists.firstWhere((element) => element['UserUid'] == uid);
    try {
      return shoppingList['Date'];
    } catch (e) {
      return convertToDate(shoppingList['Date']);
    }
  }

  // Update the checkbox state in the shopping list
  void addOrRemoveIngredientFromShoppingList(
      String docId, String uid, String ingredient, bool value) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    final shoppingListIndex =
        recipe.shoppingLists.indexWhere((element) => element['UserUid'] == uid);

    // Update the checkbox state in the shopping list
    final shoppingList = recipe.shoppingLists[shoppingListIndex];
    final List<String> ingredients = List<String>.from(shoppingList['List']);
    if (!value) {
      // Add the ingredient to the shopping list
      ingredients.add(ingredient);
    } else {
      // Remove the ingredient from the shopping list
      ingredients.remove(ingredient);
    }

    // Update the shopping list in the recipe
    recipe.shoppingLists[shoppingListIndex]['List'] = ingredients;

    // Update the shopping list in Firestore
    updateShoppingListInFirestore(docId, recipe.shoppingLists);

    notifyListeners();
  }

// Update the shopping list in Firestore
  Future<void> updateShoppingListInFirestore(
      String docId, List<Map<String, dynamic>> shoppingLists) async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(docId)
        .update({'ShoppingLists': shoppingLists});
  }

  // check if user has a meal plan
  bool checkIfCertainShoppingListExist(String docId, String uid) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    return recipe.shoppingLists.any((element) => element['UserUid'] == uid);
  }

  // get date of a meal plan
  DateTime getDate(String docId, String uid) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    final mealPlan =
        recipe.shoppingLists.firstWhere((element) => element['UserUid'] == uid);
    try {
      return mealPlan['Date'];
    } catch (e) {
      return convertToDate(mealPlan['Date']);
    }
  }

  DateTime convertToDate(Timestamp timestamp) {
    return timestamp.toDate();
  }

  // delete meal plan
  Future deleteMealPlan(String docId, String uid) async {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    await LocalNotificationService().deleteNotification(recipe.shoppingLists
        .firstWhere((element) => element['UserUid'] == uid)['NotificationId']);
    recipe.shoppingLists.removeWhere((element) => element['UserUid'] == uid);
    updateShoppingListsPerUser(uid);
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(docId)
        .update({'ShoppingLists': recipe.shoppingLists});
    notifyListeners();
  }

  // check if ingredient is in shopping list
  bool checkIfIngredientInShoppingList(
      String docId, String uid, String ingredient) {
    final recipe = _recipes.firstWhere((element) => element.docId == docId);
    final shoppingList =
        recipe.shoppingLists.firstWhere((element) => element['UserUid'] == uid);
    return !shoppingList['List'].contains(ingredient);
  }
}
