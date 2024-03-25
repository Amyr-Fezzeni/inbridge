import 'package:flutter/material.dart';
import 'package:inbridge/views/home/home.dart';
import 'package:inbridge/views/notifications/notifications.dart';
import 'package:inbridge/views/profile/profile.dart';
import 'package:inbridge/views/statistics/statistics_screen.dart';
import 'package:inbridge/views/tasks/tasks_screen.dart';
import 'package:inbridge/views/widgets/default_screen.dart';

class MenuProvider with ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  List<Map<String, dynamic>> screens = [
    {'title': "", "icon": Icons.home, 'screen': const HomeScreen()},
    {
      'title': "Tasks",
      "icon": Icons.format_list_bulleted_rounded,
      'screen': const TasksScreen()
    },
    {
      'title': "Notifications",
      "icon": Icons.search,
      'screen': const NotificationScreen()
    },
    {
      'title': "Statistics",
      "icon": Icons.search,
      'screen': const StatisticsScreen()
    },
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
