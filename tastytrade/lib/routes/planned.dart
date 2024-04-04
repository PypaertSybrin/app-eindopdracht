import 'package:flutter/material.dart';
import 'package:tastytrade/widgets/recipe_planned.dart';

class Planned extends StatelessWidget {
  const Planned({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 16, right: 16),
      child: Column(
        children: [
          const Center(
              child: Text('Planned',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecipePlanned(
                    imageLocation: 'assets/breakfast.png',
                    recipeName: 'Recipe Name',
                    date: DateTime.now()),
              );
            },
          )),
        ],
      ),
    );
  }
}
