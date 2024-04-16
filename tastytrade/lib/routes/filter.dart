import 'package:flutter/material.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/widgets/recipe_list.dart';

class Filter extends StatelessWidget {
  String filter;
  bool isCategory;
  List<RecipeModel> recipes;
  Filter(
      {super.key,
      required this.filter,
      required this.isCategory,
      required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filter,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD2B3),
      ),
      backgroundColor: const Color(0xFFFFD2B3),
      body: Column(
        children: [
          isCategory
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: null,
                        child: Container(
                            width: 96,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: const Color(0xFFFF8737),
                              border: Border.all(
                                  color: const Color(0xFFFF8737), width: 2.0),
                            ),
                            child: const Center(
                              child: Text(
                                'New',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ))),
                    TextButton(
                        onPressed: null,
                        child: Container(
                          width: 96,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: const Color(0xFFFF8737), width: 2.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Popular',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        )),
                  ],
                )
              : Container(),
          RecipeList(recipes: recipes)
        ],
      ),
    );
  }
}
