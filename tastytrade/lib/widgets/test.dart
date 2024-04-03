import 'package:flutter/material.dart';
import 'package:tastytrade/routes/favorites.dart';
import 'package:tastytrade/routes/home.dart';
import 'package:tastytrade/routes/planned.dart';
import 'package:tastytrade/routes/profile.dart';

// dit werkt dus niet omdat het geen widget is

class Test with ChangeNotifier {
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Favorites(),
    const Planned(),
    const Profile(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
