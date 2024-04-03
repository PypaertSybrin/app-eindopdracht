import 'package:flutter/material.dart';
import 'package:tastytrade/routes/favorites.dart';
import 'package:tastytrade/routes/home.dart';
import 'package:tastytrade/routes/planned.dart';
import 'package:tastytrade/routes/profile.dart';

// change notifier kan je gebruiken om de state van je app te beheren
// je kan hiermee de state van je app updaten en de widgets die luisteren naar deze state updaten
// je kan dit gebruiken om de state van je app te beheren zonder dat je de state in de widgets zelf moet bijhouden
// changenotifier werkt niet als widget, maar als een class die je kan gebruiken in een widget
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Favorites(),
    const Planned(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // index == 2 ? title = 'Settings' : title = 'Write_';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD2B3),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF8737),
        unselectedItemColor: Colors.grey[700],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
