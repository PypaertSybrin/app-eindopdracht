import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/routes/favorites.dart';
import 'package:tastytrade/routes/home.dart';
import 'package:tastytrade/routes/planned.dart';
import 'package:tastytrade/routes/profile.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/utils/navigation.dart';

// change notifier kan je gebruiken om de state van je app te beheren
// je kan hiermee de state van je app updaten en de widgets die luisteren naar deze state updaten
// je kan dit gebruiken om de state van je app te beheren zonder dat je de state in de widgets zelf moet bijhouden
// changenotifier werkt niet als widget, maar als een class die je kan gebruiken in een widget
class BottomNavigator extends StatelessWidget {
  BottomNavigator({super.key});

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    Favorites(),
    const Planned(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.watch<Navigation>().currentIndex != 3
          ? AppBar(
              title: Center(
                  child: Text(context.watch<Navigation>().getTitle,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              backgroundColor: const Color(0xFFFFD2B3),
              automaticallyImplyLeading: false,
            )
          : null,
      // floatingActionButton: context.watch<Navigation>().currentIndex == 3
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => const RecipeCreate()));
      //         },
      //         backgroundColor: const Color(0xFFFF8737),
      //         child: const Icon(Icons.add),
      //       )
      //     : null,
      backgroundColor: const Color(0xFFFFD2B3),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFFF8737),
          unselectedItemColor: Colors.grey[700],
          currentIndex: context.watch<Navigation>().currentIndex,
          onTap: (index) => context.read<Navigation>().setIndex(index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Planning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await context.read<GetRecipes>().getAllRecipes;
          },
          child: _widgetOptions
              .elementAt(context.watch<Navigation>().currentIndex)),
    );
  }
}
