import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('TastyTrade',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xFFFFD2B3),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF8737),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              'assets/lunch.png',
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
                      const Text(
                        'Recipe Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          Text('30 min'),
                        ],
                      ),
                      SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text('4 serves'),
                        ],
                      ),
                      SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(Icons.dining),
                          Text('Dinner'),
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
                              'Recipe Creator',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Ingredients',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle),
                                SizedBox(width: 8),
                                Text('Ingredient 1'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle),
                                SizedBox(width: 8),
                                Text('Ingredient 2'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle),
                                SizedBox(width: 8),
                                Text('Ingredient 3'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFFFD2B3),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Instructions',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          Text(
                              'qlmjflqkjf lqmsfjkqj fqqlkjfqmls jfqlsmfj lmkqsjflk qjslfj qlmksfj lmkqsjf lkqsjflkqjf lkmsjfklqs jflqs fjlkqsj flkqsj flkqmfj qlksfj qlksf jlskqmf jlmq flkqjflqsj fkqmlsj flqjlfmqfj sqlmkfjqsjfqlsmjflsqjfksq qslkfqslfjqksljflkqsjf qsfjkqslkmfjlksqjflkqsqm jflqsqjf qlsq fjqsqkjf mlf jslkfj qslmfj qslmfj qslfj qsmfjq skfmlqj fml dqmlj fm lqsjfqsklmfjqslmfj qsmfjkqslmjflqsjflqsmfjqsf mqslfkjqslfmjqslfj sqfjkl ksqlfjslqjfklsqjdfkldsjfldjsf lsqjfklqjsfkljqsflkjsqdlfjqslf jsqlkjflqsjflksqjfklqsf jqsljf slkqfj klqsfjlksq fjlqs fjkslqfj slkqfj lqksfj lkqsj flmqs fjlqs fj')
                        ],
                      ),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
