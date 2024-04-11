import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tastytrade/widgets/recipe_list.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RecipeList();
  }
}
