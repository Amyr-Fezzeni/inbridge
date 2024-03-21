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
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 120,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallRadius),
                    color: Colors.grey),
              ),
              Txt("Title", bold: true),
              Row(
                children: [
                  Icon(Icons.access_time_outlined,
                      size: 12, color: context.invertedColor.withOpacity(.7)),
                  const Gap(5),
                  Txt('Now',
                      size: 10, color: context.invertedColor.withOpacity(.7)),
                  const Gap(10),
                  const Icon(Icons.star, size: 15, color: Colors.orange),
                  const Gap(5),
                  Txt('5.0',
                      size: 10, color: context.invertedColor.withOpacity(.7)),
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
                    InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Icon(
                        Icons.menu,
                        color: context.invertedColor.withOpacity(.7),
                        size: 30,
                      ),
                    ),
                    logoWidget(),
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
                const Gap(10),
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
                const Gap(10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
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
