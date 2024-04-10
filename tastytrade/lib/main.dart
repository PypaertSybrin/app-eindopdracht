import 'package:flutter/material.dart';
import 'package:tastytrade/routes/bottom_navigator.dart';
import 'package:tastytrade/routes/recipe_create.dart';
import 'package:tastytrade/routes/recipe_detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RecipeCreate());
  }
}
