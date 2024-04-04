import 'package:flutter/material.dart';
import 'package:tastytrade/widgets/recipe.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
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
          child: Padding(
            padding:
                const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Sybrin Pypaert',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('4',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Recipes',
                            style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('5.1k',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Total likes',
                            style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns here
              crossAxisSpacing: 16.0, // Set the spacing between columns
              mainAxisSpacing: 16.0, // Set the spacing between rows
            ),
            itemCount: 10,
            // clipBehavior: Clip.none,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const Recipe(
                large: false,
                imageLocation: 'assets/breakfast.png',
                recipeName: 'Recipe Namesssssssssssssssssssssssssss',
                recipeCreator: 'Recipe Creatorssssssssssssssssss',
              );
            },
          ),
        ),
      ],
    );
  }
}
