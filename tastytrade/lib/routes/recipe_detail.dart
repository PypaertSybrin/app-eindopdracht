import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/services/get_recipes.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;
  final bool shoppingList;
  RecipeDetail({super.key, required this.recipe, required this.shoppingList});

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addOrRemoveLike(
      BuildContext context, String docId, String uid) async {
    await context.read<GetRecipes>().addOrRemoveLike(docId, uid);
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Select a date',
      cancelText: 'Cancel',
      confirmText: 'Select',
    );
    if (date != null) {
      DateTime selectedDate = date;
      await context
          .read<GetRecipes>()
          .createShoppingList(recipe.docId, user!.uid, selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TastyTrade',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFD2B3),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context
                  .read<GetRecipes>()
                  .checkIfCertainShoppingListExist(recipe.docId, user!.uid)
              ? null
              : selectDate(context),
          backgroundColor: const Color(0xFFFF8737),
          foregroundColor: Colors.black,
          label: context
                  .read<GetRecipes>()
                  .checkIfCertainShoppingListExist(recipe.docId, user!.uid)
              ? Text(DateFormat('dd-MM-yyyy').format(context
                  .watch<GetRecipes>()
                  .getDateOfShoppingList(recipe.docId, user!.uid)))
              : const Row(children: [
                  Text('Select a date'),
                  SizedBox(width: 8),
                  Icon(Icons.calendar_today)
                ])),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.network(
              recipe.imageLocation,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.recipeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              addOrRemoveLike(context, recipe.docId, user!.uid);
                            },
                            child: Icon(
                              context
                                      .watch<GetRecipes>()
                                      .checkIfLiked(recipe.docId, user!.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xFFFF8737),
                              size: 24.0,
                            ),
                          ),
                          Text(
                              context
                                  .watch<GetRecipes>()
                                  .getLikes(recipe.docId)
                                  .toString(),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 4),
                          Text('${recipe.minutes.toString()} mins'),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 4),
                          Text('${recipe.servings.toString()} serves'),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          const Icon(Icons.dining),
                          const SizedBox(width: 4),
                          Text(recipe.category),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Recipy by',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage:
                                  Image.network(recipe.createrProfilePicture)
                                      .image,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              recipe.createrName,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Date created',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              DateFormat('dd-MM-yyyy').format(recipe.date))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Ingredients',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipe.ingredients.length,
                            itemBuilder: (context, index) {
                              return shoppingList
                                  ? CheckboxListTile(
                                      title: Text(recipe.ingredients[index]),
                                      value: context
                                          .watch<GetRecipes>()
                                          .checkIfIngredientInShoppingList(
                                              recipe.docId,
                                              user!.uid,
                                              recipe.ingredients[index]),
                                      activeColor: const Color(0xFFFF8737),
                                      onChanged: (bool? value) {
                                        // Update the checkbox state
                                        context
                                            .read<GetRecipes>()
                                            .addOrRemoveIngredientFromShoppingList(
                                                recipe.docId,
                                                user!.uid,
                                                recipe.ingredients[index],
                                                value!);
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.circle, size: 10),
                                          const SizedBox(width: 8),
                                          Text(recipe.ingredients[index]),
                                        ],
                                      ),
                                    );
                            },
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFD2B3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Instructions',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(recipe.description)
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
