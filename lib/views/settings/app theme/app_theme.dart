import 'package:flutter/material.dart';
import 'package:inbridge/models/app_settings/theme.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/appbar.dart';

class AppThemeScreen extends StatefulWidget {
  const AppThemeScreen({super.key});

  @override
  State<AppThemeScreen> createState() => _AppThemeScreenState();
}

class _AppThemeScreenState extends State<AppThemeScreen> {
  List<AppThemeModel> themeOptions = [
    AppThemeModel.dark,
    AppThemeModel.light,
    AppThemeModel.system
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final index = themeOptions.indexOf(context.appTheme);
    Widget card(AppThemeModel theme) => InkWell(
          onTap: () => context.theme.changeDarkMode(theme),
          child: Container(
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.symmetric(vertical: 5).copyWith(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(getThemeTitle(theme),
                        style:
                            context.text.copyWith(fontWeight: FontWeight.bold)),
                    Radio(
                        value: themeOptions.indexOf(theme),
                        groupValue: index,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return context.primaryColor;
                          }
                          return context.invertedColor.withOpacity(.7);
                        }),
                        onChanged: (value) =>
                            context.theme.changeDarkMode(theme))
                  ],
                ),
                if (theme == AppThemeModel.system)
                  Txt("We'll adjust your appearence based on your device's system settings",
                      size: 12, color: context.invertedColor.withOpacity(.7))
              ],
            ),
          ),
        );
    return Scaffold(
      appBar: appBar('App theme', leading: true),
      backgroundColor: context.bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: themeOptions.map((theme) => card(theme)).toList(),
        ),
      ),
    );
  }
}
