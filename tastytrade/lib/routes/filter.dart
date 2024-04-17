import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/recipe_list.dart';

class Filter extends StatefulWidget {
  String filter;
  bool isCategory;
  Filter({super.key, required this.filter, required this.isCategory});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isPopular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filter,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD2B3),
      ),
      backgroundColor: const Color(0xFFFFD2B3),
      body: Column(
        children: [
          widget.isCategory
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isPopular = false;
                          });
                          context
                              .read<GetRecipes>()
                              .sortRecipesByCategoryAndDate(
                                  widget.filter, false);
                        },
                        child: Container(
                            width: 96,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: isPopular ? null : const Color(0xFFFF8737),
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
                        onPressed: () {
                          setState(() {
                            isPopular = true;
                          });
                          context
                              .read<GetRecipes>()
                              .sortRecipesByCategoryAndDate(
                                  widget.filter, true);
                        },
                        child: Container(
                          width: 96,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isPopular ? const Color(0xFFFF8737) : null,
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
          Expanded(
              child:
                  RecipeList(recipes: context.watch<GetRecipes>().filteredList))
        ],
      ),
    );
  }
}
