import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/providers/theme_notifier.dart';
import 'package:inbridge/providers/user_provider.dart';
import 'package:inbridge/services/shared_data.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/auth/login.dart';
import 'package:provider/provider.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    context.read<ThemeNotifier>().initTheme();
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 2), () async {
      context.userprovider
          .setDefaultLanguage(DataPrefrences.getDefaultLanguage());
      if (!await context.userprovider.checkLogin()) {
        setState(() {
          Navigator.pushReplacement(
              context, PageTransition(const LoginScreen()));
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: context.bgcolor,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _textOpacity,
                child: SizedBox(
                  width: context.w * .3,
                  // width: size,
                  child: Center(child: Txt(appName)),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: width / _containerSize,
                width: width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: Image.asset('assets/images/file_name.png')
                child: SizedBox(
                  width: context.w * .7,
                  // width: size,
                  child: Image.asset(
                    logoFull,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}
