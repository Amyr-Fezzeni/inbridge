import 'package:flutter/material.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/settings/app%20theme/app_theme.dart';
import 'package:inbridge/views/settings/contact%20info/contact_info.dart';
import 'package:inbridge/views/settings/notification%20settings/notification_settings.dart';
import 'package:inbridge/views/settings/password%20&%20security/password_security.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/settings/language/language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var style = context.watch<ThemeNotifier>();
    // Widget detailCard(
    //     {required BuildContext context,
    //     required IconData icon,
    //     required String title,
    //     Widget? screen,
    //     bool? switchValue,
    //     void Function(bool)? onSwitchTap}) {
    //   var style = context.watch<ThemeNotifier>();
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 0),
    //     child: Card(
    //       color: style.bgColor,
    //       elevation: 1,
    //       child: InkWell(
    //         onTap: screen == null
    //             ? null
    //             : () async {
    //                 await showModalBottomSheet(
    //                     isScrollControlled: true,
    //                     backgroundColor: Colors.transparent,
    //                     context: context,
    //                     builder: (context) => screen);
    //               },
    //         child: Container(
    //           decoration: BoxDecoration(
    //             border: Border.all(color: blue.withOpacity(.1)),
    //             borderRadius: BorderRadius.circular(4),
    //             color: Colors.white.withOpacity(context.isDark ? 0.1 : 1),
    //           ),
    //           width: double.infinity,
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(horizontal: 15),
    //           child: Row(
    //             children: [
    //               Icon(
    //                 icon,
    //                 color: Colors.grey,
    //                 size: 25,
    //               ),
    //               const SizedBox(
    //                 width: 15,
    //               ),
    //               Text(title, style: style.text18),
    //               const Spacer(),
    //               if (switchValue != null)
    //                 CupertinoSwitch(
    //                     activeColor: blue,
    //                     value: switchValue,
    //                     onChanged: onSwitchTap ??
    //                         (value) {
    //                           log(title);
    //                         }),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar('Settings', leading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
       
              divider(),
              Txt('User settings',
                  color: context.invertedColor.withOpacity(.7)),
              buildMenuTile(
                  title: 'Contact info',
                  icon: Icons.contact_page_outlined,
                  screen: const EditProfileScreen()),
              buildMenuTile(
                  title: 'Tax information',
                  icon: Icons.percent_rounded,
                  screen: const DefaultScreen(
                    title: 'Tax information',
                  )),
              buildMenuTile(
                  title: 'Tax information history',
                  icon: Icons.history_rounded,
                  screen: const DefaultScreen(
                    title: 'Tax information history',
                  )),
              divider(),
              Txt('Profile settings',
                  color: context.invertedColor.withOpacity(.7)),

              buildMenuTile(
                  title: 'Password & security',
                  icon: Icons.lock_outline_rounded,
                  screen: const PasswordSecurityScreen()),
              buildMenuTile(
                  title: 'Privacy preferences',
                  icon: Icons.privacy_tip_outlined,
                  screen: const DefaultScreen(title: 'Privacy preferences')),
              divider(),
              Txt('App Settings', color: context.invertedColor.withOpacity(.7)),
              buildMenuTile(
                  title: 'Language',
                  icon: Icons.language_rounded,
                  screen: const LanguageScreen()),
              buildMenuTile(
                  title: 'App theme',
                  icon: Icons.dark_mode_outlined,
                  screen: const AppThemeScreen()),
              buildMenuTile(
                  title: 'Notification settings',
                  icon: Icons.notifications_none_rounded,
                  screen: const NotificationSettings()),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 20),
              //   child: Card(
              //     color: style.bgColor,
              //     elevation: 1,
              //     child: InkWell(
              //       onTap: () => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const LanguageScreen())),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border.all(color: blue.withOpacity(.1)),
              //           borderRadius: BorderRadius.circular(4),
              //           color:
              //               Colors.white.withOpacity(style.darkMode ? 0.1 : 1),
              //         ),
              //         height: 50,
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 15, vertical: 4),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             const Icon(
              //               Icons.web,
              //               color: Colors.grey,
              //               size: 25,
              //             ),
              //             const SizedBox(
              //               width: 15,
              //             ),
              //             Text(
              //               txt('Language'),
              //               style: style.text18,
              //             ),
              //             const Spacer(),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               size: 15,
              //               color: style.invertedColor,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // detailCard(
              //     context: context,
              //     icon: Icons.dark_mode_outlined,
              //     switchValue: style.darkMode,
              //     onSwitchTap: (value) =>
              //         context.read<ThemeNotifier>().changeDarkMode(value),
              //     title: txt("Dark mode")),
              // detailCard(
              //     context: context,
              //     icon: Icons.notifications_none_rounded,
              //     switchValue:
              //         context.watch<UserProvider>().isNotificationActive,
              //     onSwitchTap: (bool value) => context
              //         .read<UserProvider>()
              //         .changeNoticationStatus(value),
              //     title: txt("Notifications")),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
