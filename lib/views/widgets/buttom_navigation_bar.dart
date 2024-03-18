import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbridge/constants/constants.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            url != null
                ? svgImage(url,
                    selected:
                        context.watch<MenuProvider>().currentPage == index)
                : Icon(
                    icon,
                    size: 20,
                    color: context.watch<MenuProvider>().currentPage == index
                        ? context.primaryColor
                        : context.invertedColor.withOpacity(.7),
                  ),
            Txt(title,
                style: context.text.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: context.watch<MenuProvider>().currentPage == index
                        ? context.primaryColor
                        : context.invertedColor.withOpacity(.7)))
          ],
        ),
      );
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: context.invertedColor.withOpacity(.1))),
        color: context.bgcolor,
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            iconBar(Icons.search, txt('Jobs'), 0, url: search),
            iconBar(Icons.edit_document, txt('Proposals'), 1),
            iconBar(Icons.description_rounded, txt('Contracts'), 2),
            iconBar(Icons.message_rounded, txt('Messages'), 3, url: message),
            iconBar(Icons.notifications_none, txt('Alerts'), 4,
                url: notification),
          ]),
    );
  }
}
