import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  icon: svgImage(filter,
                      size: 25, function: () {}, color: context.iconColor),
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
