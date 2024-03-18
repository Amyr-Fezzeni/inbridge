import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inbridge/models/user.dart';
import 'package:inbridge/services/user_service.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/buttom_navigation_bar.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/views/widgets/nav_panel_customer.dart';

class StructureHomeScreen extends StatefulWidget {
  const StructureHomeScreen({super.key});

  @override
  State<StructureHomeScreen> createState() => _StructureHomeScreenState();
}

class _StructureHomeScreenState extends State<StructureHomeScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        log('true');
        UserService.connectStatus(true);

        break;
      case AppLifecycleState.inactive:
        log('false');
        UserService.connectStatus(false);

        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      drawer: const NavPanel(),
      backgroundColor: context.bgcolor,
      appBar: appBar(context.currentPageTitle, leadingProfile: true),
      body: Container(
        child: (context.currentUser.status == UserStatus.banned)
            ? const DefaultScreen(
                title: '',
              )
            : context.screens[context.currentPage]['screen'],
      ),
      bottomNavigationBar: (context.currentUser.status == UserStatus.banned)
          ? null
          : const CustomBottomNavigationBar(),
    );
  }
}
