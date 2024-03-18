import 'package:flutter/material.dart';
import 'package:inbridge/models/app_settings/theme.dart';
import 'package:inbridge/providers/menu_provider.dart';
import 'package:inbridge/providers/notification_provider.dart';
import 'package:inbridge/providers/profile_provider.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/services/util/page_transitions.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../providers/theme_notifier.dart';
import '../../providers/user_provider.dart';

extension ContextExt on BuildContext {
  double get h => MediaQuery.of(this).size.height;

  double get w => MediaQuery.of(this).size.width;

  TextStyle get text => watch<ThemeNotifier>().text18;

  TextStyle get title => watch<ThemeNotifier>().title;

  Color get bgcolor => watch<ThemeNotifier>().bgColor;
  Color get primaryColor => watch<ThemeNotifier>().primaryColor;
  Color get secondaryColor => watch<ThemeNotifier>().secondaryColor;

  AppThemeModel get appTheme => watch<ThemeNotifier>().appTheme;

  ThemeNotifier get theme => read<ThemeNotifier>();

  LanguageModel get currentLanguage => watch<UserProvider>().currentLanguage;
  UserProvider get userprovider => read<UserProvider>();

  String get userId => userprovider.currentUser!.id;
  bool get isDark => watch<ThemeNotifier>().appTheme == AppThemeModel.system
      ? getSystemTheme()
      : watch<ThemeNotifier>().appTheme == AppThemeModel.dark;

  Color get invertedColor => watch<ThemeNotifier>().invertedColor;

  Color get navBarColor => watch<ThemeNotifier>().navBarColor;

  Color get panelColor => watch<ThemeNotifier>().panelColor;

  UserModel get currentUser => watch<UserProvider>().currentUser!;

  int get currentPage => watch<MenuProvider>().currentPage;

  String get currentPageTitle => screens[currentPage]['title'];

  List<Map<String, dynamic>> get screens => watch<MenuProvider>().screens;

  moveTo(Widget screen) => Navigator.push(this, SlideTransition1(screen));
  replaceWith(Widget screen) => Navigator.pushReplacement(
      this, MaterialPageRoute(builder: (context) => screen));
  moveToAndRemoveHistory(Widget screen) =>
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false);

  showPopUpScreen(Widget screen) => showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: this,
      builder: (context) => screen);


  bool get isFreelancer => currentUser.role == UserRole.freelance;

  NotificationProvider get notificationProvider => read<NotificationProvider>();
  NotificationProvider get watchNotification => watch<NotificationProvider>();

  ProfileProvider get profileProvider => read<ProfileProvider>();
  ProfileProvider get profileWatch => watch<ProfileProvider>();

}