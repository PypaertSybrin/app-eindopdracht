import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/routes/recipe_create.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/recipe_list.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  // get current user displayname
  final User? user = FirebaseAuth.instance.currentUser;

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Image.network(
                            fit: BoxFit.cover,
                            user!.photoURL.toString(),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Return the actual image widget once loading is complete
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFF8737),
                                  ),
                                ); // Return a progress indicator while loading
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user!.displayName.toString(),
                          style: const TextStyle(
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
                            Text(
                                context
                                    .watch<GetRecipes>()
                                    .userRecipes
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text('Recipes',
                                style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                context
                                    .watch<GetRecipes>()
                                    .getTotalLikes(user!.uid)
                                    .toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Total likes',
                                style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecipeCreate()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text('Add a recipe',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: RecipeList(
                recipes: context
                    .watch<GetRecipes>()
                    .userRecipes)),
      ],
    );
  }
}
