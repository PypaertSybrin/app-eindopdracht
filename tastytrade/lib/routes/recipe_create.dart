import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RecipeCreate extends StatefulWidget {
  @override
  _Recipe createState() => _Recipe();
}

class _Recipe extends State<RecipeCreate> {
  final List<String> categories = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Desert'
  ];
  final List<String> ingredients = [];
  String currentIngredient = '';

  void addIngredient() {
    if (currentIngredient.isNotEmpty) {
      setState(() {
        ingredients.add(currentIngredient);
        currentIngredient = '';
      });
    }
  }

  void deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('TastyTrade',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: const Color(0xFFFFD2B3),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFFF8737),
          child: const Icon(Icons.delete, color: Colors.black),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          onPressed: () => {},
          backgroundColor: const Color(0xFFFF8737),
          child: const Icon(Icons.save, color: Colors.black),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(color: Colors.grey),
              child: TextButton(
                onPressed: () {
                  print('test');
                },
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Recipe Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Time (min.)',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Serves',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownMenu<String>(
                          hintText: 'Category',
                          dropdownMenuEntries: categories
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Ingredient',
                            border: OutlineInputBorder(),
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Ingredient ${index + 1}: ${ingredients[index]}',
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
                  const SizedBox(height: 8),
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Instructions',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
