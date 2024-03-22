import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/models/app_settings/theme.dart';
import 'package:inbridge/models/enum_classes.dart';
import 'package:inbridge/views/profile/profile.dart';
import 'package:inbridge/views/settings/contact%20info/contact_info.dart';
import 'package:inbridge/views/settings/language/language_screen.dart';
import 'package:inbridge/views/settings/password%20&%20security/password/change_password.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/popup.dart';
import 'package:provider/provider.dart';
import '../../constants/fixed_messages.dart';
import '../../providers/user_provider.dart';
import '../../services/util/language.dart';
import '../../services/util/navigation_service.dart';
import '../settings/settings.dart';

class NavPanel extends StatelessWidget {
  const NavPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * .7,
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
          color: context.bgcolor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Future.delayed(const Duration(milliseconds: 100))
                      .then((value) => context.moveTo(const ProfileScreen()));
                },
                child: Row(children: [
                  profileIcon(size: 50),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Txt(context.currentUser.getFullName()))
                ]),
              ),
              const Gap(20),
              if (context.currentUser.role == Role.creator)
                Card(
                  color: context.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Builder(builder: (context) {
                          return SizedBox(
                            // height: 50,
                            child: CircularPercentIndicator(
                              radius: 25.0,
                              lineWidth: 4.0,
                              percent: 1,
                              center:
                                  Txt("100%", color: Colors.white, size: 12),
                              progressColor: Colors.white,
                            ),
                          );
                        }),
                        const Gap(5),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt('Profile Completeness',
                                  bold: true, color: Colors.white, size: 12),
                              Txt('Quality profiles are 5 times more likely to get hired by clinets.',
                                  color: Colors.white, size: 12),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              const Gap(10),
              buildMenuTile(
                  title: txt('Edit informations'),
                  icon: Icons.edit_note,
                  screen: const EditProfileScreen()),
              buildMenuTile(
                  title: txt('Change password'),
                  icon: Icons.lock,
                  screen: const ChangePassword()),
              divider(bottom: 5),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Txt('App Settings', color: context.primaryColor),
              ),
              divider(bottom: 10),
              buildMenuTile(
                  title: 'Language',
                  icon: Icons.language_rounded,
                  screen: const LanguageScreen()),
              ListTile(
                  title: Txt("App theme"),
                  trailing: CupertinoSwitch(
                      value: context.isDark,
                      activeColor: context.primaryColor,
                      onChanged: (value) {
                        context.theme.changeDarkMode(
                            value ? AppThemeModel.dark : AppThemeModel.light);
                      })),
              ListTile(
                  title: Txt("Notification"),
                  trailing: CupertinoSwitch(
                      value: context.currentUser.notificationStatus,
                      activeColor: context.primaryColor,
                      onChanged: (value) {
                        context.notificationProvider
                            .updateNotificationStatus(value);
                      })),
              const SizedBox(
                height: 20,
              ),
              // buildMenuTile(
              //     title: txt('Settings'),
              //     icon: Icons.settings,
              //     screen: const SettingsScreen()),
              divider(bottom: 5),
              Builder(builder: (context) {
                return InkWell(
                  onTap: () async {
                    Scaffold.of(context).closeDrawer();
                    Future.delayed(const Duration(milliseconds: 100)).then(
                        (value) => popup(
                            NavigationService.navigatorKey.currentContext!,
                            "Ok",
                            confirmFunction: () => NavigationService
                                .navigatorKey.currentContext!
                                .read<UserProvider>()
                                .logOut(NavigationService
                                    .navigatorKey.currentContext!),
                            description: '${txt(logoutMessage)}?'));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 15),
                        child: Icon(
                          Icons.logout_rounded,
                          color: context.invertedColor.withOpacity(.7),
                          size: 25,
                        ),
                      ),
                      Txt("Logout")
                    ],
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
