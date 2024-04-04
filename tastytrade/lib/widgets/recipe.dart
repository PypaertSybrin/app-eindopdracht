import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  final String imageLocation;
  final String recipeName;
  final String recipeCreator;
  final bool large;

  const Recipe(
      {Key? key,
      required this.imageLocation,
      required this.recipeName,
      required this.recipeCreator,
      required this.large})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: large ? MediaQuery.of(context).size.width * 0.6 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
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
              Text(recipeName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  )),
              Text(recipeCreator,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey[700])),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  const Text('1.3k'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
