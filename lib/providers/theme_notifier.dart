import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/models/app_settings/theme.dart';
import 'package:inbridge/services/util/navigation_service.dart';
import 'package:inbridge/services/shared_data.dart';

class ThemeNotifier with ChangeNotifier {
  Color bgColor = lightBgColor;
  TextStyle text18 = text18black;
  TextStyle title = titleblack;
  AppThemeModel appTheme = AppThemeModel.system;
  bool isDark = false;
  Color invertedColor = darkBgColor;
  Color navBarColor = lightnavBarColor;
  Color panelColor = lightPanelColor;
  Color primaryColor = primaryColorLight;
  Color secondaryColor = secndaryClorLight;

  void changeDarkMode(AppThemeModel value) async {
    isDark = value == AppThemeModel.system
        ? getSystemTheme()
        : value == AppThemeModel.dark;
    switch (isDark) {
      case true:
        bgColor = darkBgColor;
        panelColor = darkPanelColor;
        text18 = text18white;
        title = titleWhite;
        invertedColor = lightBgColor;
        navBarColor = darknavBarColor;
        primaryColor = primaryColorDark;
        secondaryColor = secndaryClorDark;
        break;
      case false:
        bgColor = lightBgColor;
        panelColor = lightPanelColor;
        text18 = text18black;
        title = titleblack;
        invertedColor = darkBgColor;
        navBarColor = lightnavBarColor;
        primaryColor = primaryColorLight;
        secondaryColor = secndaryClorLight;
        break;
      default:
        break;
    }
    appTheme = value;
    notifyListeners();
    DataPrefrences.setDarkMode(value);
    // log("app theme :${DataPrefrences.getDarkMode()}");
  }

  initTheme() {
    appTheme = getAppThemeFromString(DataPrefrences.getDarkMode());
    // log(appTheme.toString());
    isDark = appTheme == AppThemeModel.system
        ? getSystemTheme()
        : appTheme == AppThemeModel.dark;
    switch (isDark) {
      case true:
        bgColor = darkBgColor;
        panelColor = darkPanelColor;
        text18 = text18white;
        title = titleWhite;
        invertedColor = lightBgColor;
        navBarColor = darknavBarColor;
        primaryColor = primaryColorDark;
        secondaryColor = secndaryClorDark;

        break;
      case false:
        bgColor = lightBgColor;
        panelColor = lightPanelColor;
        text18 = text18black;
        title = titleblack;
        invertedColor = darkBgColor;
        navBarColor = lightnavBarColor;
        primaryColor = primaryColorLight;
        secondaryColor = secndaryClorLight;

        break;
      default:
        break;
    }
    startThemeListen();
  }

  startThemeListen() {
    // log(appTheme.toString());
    if (appTheme != AppThemeModel.system) return;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // log(systemThemeChanged().toString());
      if (appTheme != AppThemeModel.system) timer.cancel();

      if (systemThemeChanged()) {
        isDark = !isDark;
        switch (isDark) {
          case true:
            bgColor = darkBgColor;
            panelColor = darkPanelColor;
            text18 = text18white;
            title = titleWhite;
            invertedColor = lightBgColor;
            navBarColor = darknavBarColor;
            primaryColor = primaryColorDark;
            secondaryColor = secndaryClorDark;
            break;
          case false:
            bgColor = lightBgColor;
            panelColor = lightPanelColor;
            text18 = text18black;
            title = titleblack;
            invertedColor = darkBgColor;
            navBarColor = lightnavBarColor;
            primaryColor = primaryColorLight;
            secondaryColor = secndaryClorLight;
            break;
          default:
            break;
        }
        log('Dark mode changed');
        notifyListeners();
      }
    });
  }

  bool systemThemeChanged() {
    if (MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                    .platformBrightness ==
                Brightness.dark &&
            !isDark ||
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                    .platformBrightness ==
                Brightness.light &&
            isDark) {
      return true;
    } else {
      return false;
    }
  }
}
