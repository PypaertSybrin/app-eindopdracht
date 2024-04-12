import 'package:flutter/material.dart';
import 'package:tastytrade/widgets/recipe_planned.dart';

class Planned extends StatelessWidget {
  const Planned({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: 10,
        clipBehavior: Clip.none,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return RecipePlanned(
              imageLocation: 'assets/breakfast.png',
              recipeName: 'Recipe Namesssssssssssssssssssssssssss',
              date: DateTime.now());
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
