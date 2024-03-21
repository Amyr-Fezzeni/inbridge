import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/logic_service.dart';
import 'package:inbridge/views/notifications/notifications.dart';
import 'package:inbridge/views/settings/contact%20info/contact_info.dart';
import 'package:inbridge/views/settings/settings.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:inbridge/providers/theme_notifier.dart';

import '../../constants/constants.dart';
import '../../constants/fixed_messages.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../services/util/language.dart';
import '../../services/user_service.dart';
import '../../views/widgets/bottuns.dart';
import '../../views/widgets/popup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabItem({required String lable, int index = 0}) {
      return SizedBox(
        height: 40,
        width: double.infinity,
        child: Center(
          child: Txt(
            lable,
            bold: controller.index == index,
            // size: 20,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.bgcolor,
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 40),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(80)),
                      child: profileIcon(size: 150),
                    ),
                    Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () async {
                            final file = await pickImage();
                            if (file == null) return;

                            await UserService.uploadUserImage(
                                await UserService.uploadImage(
                                    File(file.path.toString()),
                                    folder: 'profile',
                                    type: file.extension.toString()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: defaultShadow,
                                color: secndaryClorDark,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(Icons.camera_alt_outlined,
                                color: Colors.white, size: 25),
                          ),
                        ))
                  ],
                ),
              ),
              Txt(context.currentUser.getFullName(), size: 20, bold: true),
              const Gap(30),
              CustomTextField(
                hint: txt('Search'),
                controller: TextEditingController(),
                leadingIcon: Icon(Icons.search,
                    color: context.invertedColor.withOpacity(.7), size: 25),
                icon: svgImage(filter, size: 25, function: () {}),
                height: 50,
              ),
              const Gap(20),
              DefaultTabController(
                length: 2,
                child: TabBar(
                  padding: const EdgeInsets.all(0),
                  labelPadding: const EdgeInsets.all(0),
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => context.primaryColor),
                  indicatorColor: context.primaryColor,
                  controller: controller,
                  labelStyle: context.text,
                  onTap: (int i) => setState(() {}),
                  tabs: [
                    tabItem(lable: txt('Public'), index: 0),
                    tabItem(lable: txt('Private'), index: 1),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: controller,
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 500,
                      width: context.w,
                      // color: Colors.red,
                    ),
                    SizedBox(
                      height: 500,
                      width: context.w,
                      // color: Colors.amber,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
