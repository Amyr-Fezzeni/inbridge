import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget card() => SizedBox(
          // height: 100,
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallRadius),
                    color: Colors.grey),
              ),
              Txt("Title"),
              Row(
                children: [
                  Icon(Icons.access_time_outlined,
                      size: 12, color: context.invertedColor.withOpacity(.7)),
                  const Gap(5),
                  Txt('Now', size: 12),
                  const Gap(10),
                  const Icon(Icons.star, size: 15, color: Colors.orange),
                  const Gap(5),
                  Txt('5.0 Rating', size: 12),
                ],
              )
            ],
          ),
        );
    return Scaffold(
      backgroundColor: context.bgcolor,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Image.asset(logo, width: 60), Txt("InBridge")],
                    ),
                    profileIcon(size: 50)
                  ],
                ),
                const Gap(20),
                CustomTextField(
                  hint: txt('Search'),
                  controller: TextEditingController(),
                  leadingIcon: Icon(Icons.search,
                      color: context.invertedColor.withOpacity(.7), size: 25),
                  icon: svgImage(filter, size: 25, function: () {}),
                  marginH: 0,
                  height: 50,
                ),
                const Gap(20),
                Row(
                  children: [
                    Icon(Icons.local_fire_department,
                        color: context.invertedColor.withOpacity(.7), size: 25),
                    const Gap(5),
                    Txt("Recent Projects", bold: true)
                  ],
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(15, (index) => card()),
                    ),
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    Icon(Icons.folder_copy_outlined,
                        color: context.invertedColor.withOpacity(.7), size: 25),
                    const Gap(5),
                    Txt("See all", bold: true)
                  ],
                ),
                SizedBox(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      15,
                      (index) => card(),
                    ),
                  ),
                ),
                const Gap(60),
              ],
            )),
      ),
    );
  }
}
