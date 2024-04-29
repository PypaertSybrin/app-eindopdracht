import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/models/recipe_model.dart';
import 'package:tastytrade/services/get_recipes.dart';

class RecipeCreate extends StatefulWidget {
  const RecipeCreate({super.key});

  @override
  State<RecipeCreate> createState() => _Recipe();
}

class _Recipe extends State<RecipeCreate> {
  final storageRef = FirebaseStorage.instance.ref();
  File? image;
  bool isLoading = false;

  String docId = '';
  String imageLocation = '';
  String recipeName = '';
  String createrName = '';
  String createrUid = '';
  String createrProfilePicture = '';
  int minutes = 0;
  int servings = 0;
  String category = '';
  List<String> ingredients = [];
  String description = '';
  List<String> likes = [];
  List<Map<String, dynamic>> shoppingLists = [];

  final List<String> categories = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert'
  ];
  String currentIngredient = '';

  Future<String> getPictureReference() async {
    final imageLocation = storageRef.child(image!.path);
    var location = await imageLocation
        .putFile(image!)
        .then((value) => value.ref.getDownloadURL());
    return location;
  }

  void saveRecipe(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    if (image != null &&
        recipeName.isNotEmpty &&
        minutes != 0 &&
        servings != 0 &&
        category.isNotEmpty &&
        ingredients.isNotEmpty &&
        description.isNotEmpty) {
      getPictureReference().then((location) {
        createrName = FirebaseAuth.instance.currentUser!.displayName!;
        createrUid = FirebaseAuth.instance.currentUser!.uid;
        if (FirebaseAuth.instance.currentUser!.photoURL != null) {
          createrProfilePicture = FirebaseAuth.instance.currentUser!.photoURL!;
        }
        final recipe = RecipeModel(
          docId: docId,
          imageLocation: location,
          recipeName: recipeName,
          createrName: createrName,
          createrUid: createrUid,
          createrProfilePicture: createrProfilePicture,
          minutes: minutes,
          servings: servings,
          category: category,
          ingredients: ingredients,
          description: description,
          likes: likes,
          shoppingLists: shoppingLists,
          date: DateTime.now(),
        );

        context.read<GetRecipes>().addRecipe(recipe).then((_) {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and add an image.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  final ingredientController = TextEditingController();
  void addIngredient() {
    if (currentIngredient.isNotEmpty) {
      setState(() {
        ingredients.add(currentIngredient);
        currentIngredient = '';
      });
      ingredientController.clear();
    }
  }

  void deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  Future showOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                pickImage('camera');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                pickImage('gallery');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future pickImage(String source) async {
    try {
      final image = await ImagePicker().pickImage(
          source:
              source == 'camera' ? ImageSource.camera : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException {
      // print('Failed to pick image');
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: image != null
                      ? DecorationImage(
                          image: FileImage(image!), fit: BoxFit.cover)
                      : null),
              child: TextButton(
                onPressed: () {
                  showOptions();
                },
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: image == null
                    ? const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 50,
                      )
                    : Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Recipe Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black), // Set border color here
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) => recipeName = value,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              labelText: 'Time (min.)',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.black), // Set border color here
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) => minutes = int.parse(value),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              labelText: 'Serves',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.black), // Set border color here
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) => servings = int.parse(value),
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownMenu<String>(
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.grey[50]),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          hintText: 'Category',
                          dropdownMenuEntries: categories
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                          onSelected: (String? value) {
                            setState(() {
                              category = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ingredientController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Ingredient',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // Set border color here
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              currentIngredient = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: addIngredient,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xFFFFD2B3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your ingredients:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            ingredients.isEmpty
                                ? const Text(
                                    'Enter an ingredient and press \'+\'')
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: ingredients.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              ingredients[index],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => deleteIngredient(
                                                index), // Pass index to delete function
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Instructions',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black), // Set border color here
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (value) => description = value,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      saveRecipe(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFFFF8737),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 3, color: Colors.black))
                                : const Text('Save Recipe',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
