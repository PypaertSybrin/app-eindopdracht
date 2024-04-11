import 'package:flutter/material.dart';

class RecipeModel {
  String imageLocation;
  String recipeName;
  String createrName;
  String createrUid;
  int minutes;
  int servings;
  String category;
  List<String> ingredients;
  String description;
  int likes;
  int views;
  DateTime date;
  RecipeModel({
    required this.imageLocation,
    required this.recipeName,
    required this.createrName,
    required this.createrUid,
    required this.minutes,
    required this.servings,
    required this.category,
    required this.ingredients,
    required this.description,
    required this.likes,
    required this.views,
    required this.date,
  });
}
