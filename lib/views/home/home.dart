import 'package:flutter/material.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/default_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      body: Container(
        height: context.h,
        width: context.w,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const DefaultScreen(
          title: 'Home',
        ),
      ),
    );
  }
}
