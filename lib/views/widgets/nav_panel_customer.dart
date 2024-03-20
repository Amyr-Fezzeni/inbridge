import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/models/enum_classes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/profile/profile.dart';
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
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(children: [
                    profileIcon(size: 50),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(context.currentUser.getFullName()),
                              Txt(
                                  context.currentUser.role == Role.creator
                                      ? 'Creator'
                                      : 'Admin',
                                  style: context.text)
                            ]))
                  ]),
                  const SizedBox(height: 20),
                ],
              ),
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
                              center: Txt(
                                  "100%",
                                  color: Colors.white,
                                  size: 12),
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
                  title: txt('Profile'),
                  icon: Icons.person,
                  screen: const ProfileScreen()),
              buildMenuTile(
                  title: txt('My stats'),
                  icon: Icons.bar_chart_rounded,
                  screen:
                      const DefaultScreen(title: 'My stats', leading: true)),
              buildMenuTile(
                  title: txt('Reports'),
                  icon: Icons.pie_chart,
                  screen: const DefaultScreen(title: 'Report', leading: true)),
              divider(bottom: 5),
              buildMenuTile(
                  title: txt('Settings'),
                  icon: Icons.settings,
                  screen: const SettingsScreen()),
              buildMenuTile(
                  title: txt('Help & Support'),
                  icon: Icons.contact_support_outlined,
                  screen: const DefaultScreen(
                      title: 'Helps & support', leading: true)),
              const Spacer(),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.logout_rounded,
                          color: context.invertedColor.withOpacity(.7),
                          size: 25,
                        ),
                      ),
                      Txt("Log Out")
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
