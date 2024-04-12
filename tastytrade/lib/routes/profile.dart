import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: user!.photoURL != null
                          ? NetworkImage(user!.photoURL.toString())
                          : null,
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
            child: RecipeList(recipes: context.read<GetRecipes>().recipes)),
      ],
    );
  }
}
