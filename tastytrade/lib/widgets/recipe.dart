import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Recipe extends StatelessWidget {
  final String imageLocation;
  final String recipeName;
  final String recipeCreator;

  const Recipe(
      {Key? key,
      required this.imageLocation,
      required this.recipeName,
      required this.recipeCreator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 220,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  imageLocation,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(recipeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              SizedBox(
                  width: 220,
                  child: Text(recipeCreator,
                      style: const TextStyle(
                          fontSize: 16, overflow: TextOverflow.ellipsis))),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
