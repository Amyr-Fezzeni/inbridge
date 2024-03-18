import 'package:flutter/material.dart';
import 'package:inbridge/views/home/home.dart';
import 'package:inbridge/views/widgets/default_screen.dart';

class MenuProvider with ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  List<Map<String, dynamic>> screens = [
    {'title': "", "icon": Icons.search, 'screen': const HomeScreen()},
    {
      'title': "Proposals",
      "icon": Icons.search,
      'screen': const DefaultScreen(
        title: 'Proposals',
        appbar: false,
      )
    },
    {
      'title': "Contracts",
      "icon": Icons.search,
      'screen': const DefaultScreen(
        title: 'Contracts',
        appbar: false,
      )
    },
    {
      'title': "Messages",
      "icon": Icons.search,
      'screen': const DefaultScreen(
        title: '',
      )
    },
    {
      'title': "Alerts",
      "icon": Icons.search,
      'screen': const DefaultScreen(
        title: 'Alerts',
        appbar: false,
      )
    }
  ];

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }

  void init() {
    _currentPage = 0;
  }
}
