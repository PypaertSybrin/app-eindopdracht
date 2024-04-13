class RecipeModel {
  String docId;
  String imageLocation;
  String recipeName;
  String createrName;
  String createrUid;
  String createrProfilePicture;
  int minutes;
  int servings;
  String category;
  List<String> ingredients;
  String description;
  List<String> likes;
  List<Map<String, dynamic>> mealPlans;
  DateTime date;
  RecipeModel({
    required this.docId,
    required this.imageLocation,
    required this.recipeName,
    required this.createrName,
    required this.createrUid,
    required this.createrProfilePicture,
    required this.minutes,
    required this.servings,
    required this.category,
    required this.ingredients,
    required this.description,
    required this.likes,
    required this.mealPlans,
    required this.date,
  });
}
