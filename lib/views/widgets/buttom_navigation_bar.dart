import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:inbridge/providers/menu_provider.dart';
import 'package:inbridge/services/util/language.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget iconBar(IconData icon, String title, int index, {String? url}) {
      return InkWell(
        onTap: () {
          context.read<MenuProvider>().updateCurrentPage(index);
          HapticFeedback.lightImpact();
        },
        child: url != null
            ? svgImage(url, selected: context.currentPage == index)
            : Icon(
                icon,
                size: 25,
                color: context.currentPage == index
                    ? context.primaryColor
                    : context.invertedColor.withOpacity(.7),
              ),
      );
    }

    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: context.invertedColor.withOpacity(.1))),
                color: context.bgcolor,
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    iconBar(
                        Icons.photo_size_select_actual_rounded, txt('Home'), 0),
                    iconBar(Icons.checklist_rounded, txt('Tasks'), 1),
                    const Gap(20),
                    iconBar(Icons.notifications_none, txt('Notifications'), 2),
                    iconBar(Icons.people_alt_outlined, txt('Profile'), 3),
                  ]),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Center(
                child: InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: defaultShadow,
                        color: secndaryClorDark,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.add, color: Colors.white, size: 35),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
