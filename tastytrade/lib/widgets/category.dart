import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/routes/filter.dart';
import 'package:tastytrade/services/get_recipes.dart';

class Category extends StatelessWidget {
  final String imageLocation;
  final String category;

  const Category(this.imageLocation, this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.30),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.read<GetRecipes>().sortRecipesByCategoryAndDate(category, false);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Filter(
                filter: category,
                isCategory: true);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imageLocation,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                  child: Text(category,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
