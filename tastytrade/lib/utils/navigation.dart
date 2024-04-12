import 'package:flutter/material.dart';

class Navigation with ChangeNotifier {
  int _currentIndex = 0;
  String title = 'TastyTrade';
  int get currentIndex => _currentIndex;
  String get getTitle => title;

  void setIndex(int index) {
    _currentIndex = index;
    index == 1
        ? title = 'Favorites'
        : index == 2
            ? title = 'Planning'
            : index == 3
                ? title = 'Profile'
                : title = 'TastyTrade';
    notifyListeners();
  }
}
