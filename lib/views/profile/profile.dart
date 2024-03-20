import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/views/notifications/notifications.dart';
import 'package:inbridge/views/settings/contact%20info/contact_info.dart';
import 'package:inbridge/views/settings/settings.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/default_screen.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/loader.dart';
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

class ProfileScreenOld extends StatefulWidget {
  const ProfileScreenOld({super.key});

  @override
  State<ProfileScreenOld> createState() => _ProfileScreenOldState();
}

class _ProfileScreenOldState extends State<ProfileScreenOld> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    UserModel user = context.watch<UserProvider>().currentUser!;
    Widget settingCard(
        {required String title,
        required IconData icon,
        void Function()? function,
        Widget? screen,
        Color? color,
        Widget? trailing}) {
      return Card(
        elevation: 4,
        color: style.bgColor,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.primaryColor.withOpacity(.1)),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white.withOpacity(context.isDark ? 0.05 : 1),
          ),
          child: ListTile(
              minLeadingWidth: 20,
              onTap: function ??
                  () => (screen != null
                      ? Navigator.push(context,
                          MaterialPageRoute(builder: (context) => screen))
                      : {}),
              tileColor: Colors.white.withOpacity(context.isDark ? 0.05 : 1),
              title: Text(
                title,
                style: style.text18,
              ),
              leading: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: (color ?? context.primaryColor).withOpacity(.7),
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              trailing: trailing ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: style.invertedColor.withOpacity(.7),
                    size: 20,
                  )),
        ),
      );
    }

    Future pickImageGallery() async {
      try {
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (image == null) {
          setState(() {
            isLoading = false;
          });
          return;
        }

        final imageTemp = File(
          image.path,
        );
        final url = await UserService.uploadImage(imageTemp,
            folder: 'profile', type: image.name.split('.').last);
        log(url);
        await UserService.uploadUserImage(url);
      } on PlatformException catch (e) {
        log('Failed to pick image: $e');
      }
      setState(() {
        isLoading = false;
      });
    }

    Future pickImageCamera() async {
      try {
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
        final image = await ImagePicker().pickImage(source: ImageSource.camera);

        if (image == null) {
          setState(() {
            isLoading = false;
          });
          return;
        }

        final imageTemp = File(image.path);
        final url = await UserService.uploadImage(imageTemp,
            folder: 'profile', type: image.name.split('.').last);
        log(url);
        await UserService.uploadUserImage(url);
      } on PlatformException catch (e) {
        log('Failed to pick image: $e');
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: style.bgColor,
      appBar: appBar('Profile'),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 220,
              width: context.w,
              // color: Colors.amber,
              child: Stack(
                children: [
                  const SizedBox(
                    height: 145,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: Center(
                      child: Hero(
                        tag: "profile",
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: style.bgColor,
                            border: Border.all(color: style.bgColor, width: 3),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  color: Colors.black38)
                            ],
                          ),
                          child: isLoading
                              ? Center(child: cLoader())
                              : InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) =>
                                            DraggableScrollableSheet(
                                                initialChildSize: 0.3,
                                                expand: false,
                                                builder: (_, c) => Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: style.bgColor,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        gradientButton(
                                                            function:
                                                                pickImageGallery,
                                                            w: context.w * 0.7,
                                                            h: 50,
                                                            text: txt(
                                                                "Pick an Image")),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        gradientButton(
                                                            function:
                                                                pickImageCamera,
                                                            w: context.w * 0.7,
                                                            h: 50,
                                                            text: txt(
                                                                "Open Camera")),
                                                      ],
                                                    ))));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.network(
                                      user.photo,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        profileImg,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 50,
                      child: SizedBox(
                        // width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (_) =>
                            //                 const SettingsScreen()));
                            //   },
                            //   child: Hero(
                            //     tag: "settings",
                            //     child: Container(
                            //       height: 60,
                            //       width: 60,
                            //       padding: const EdgeInsets.all(10),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(50),
                            //         color: style.bgColor,
                            //         boxShadow: const [
                            //           BoxShadow(
                            //               offset: Offset(0, 3),
                            //               blurRadius: 10,
                            //               color: Colors.black38)
                            //         ],
                            //       ),
                            //       child: Center(
                            //         child: Icon(
                            //           Icons.settings,
                            //           color: style.invertedColor,
                            //           size: 35,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            SizedBox(
                              child: Hero(
                                tag: "notification",
                                child: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: style.bgColor,
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10,
                                                  color: Colors.black38)
                                            ],
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const NotificationScreen()));
                                            },
                                            icon: Icon(
                                              Icons.notifications,
                                              color: style.invertedColor,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Center(
                                              child: Text(
                                                context.watchNotification
                                                    .notifications
                                                    .where((element) =>
                                                        !element.seen)
                                                    .toList()
                                                    .length
                                                    .toString(),
                                                style: style.text18.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                color: style.bgColor,
                elevation: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          "${user.firstName} ${user.lastName}",
                          style: style.title.copyWith(fontSize: 25),
                        ),
                      ),
                      settingCard(
                          title: txt("Edit Profile"),
                          icon: Icons.person,
                          screen: const EditProfileScreen()),
                      settingCard(
                          title: txt('Settings'),
                          icon: Icons.settings,
                          color: Colors.grey,
                          screen: const SettingsScreen()),
                      settingCard(
                          title: txt('Privacy Policy'),
                          icon: Icons.privacy_tip_outlined,
                          color: Colors.green,
                          screen: const DefaultScreen(
                            title: "Privacy policy",
                          )),
                      settingCard(
                          title: txt('Terms and conditions'),
                          icon: Icons.privacy_tip_outlined,
                          color: Colors.green,
                          screen: const DefaultScreen(
                            title: "Terms & conditions",
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: settingCard(
                            title: txt("Logout"),
                            icon: Icons.logout_rounded,
                            color: Colors.grey,
                            trailing: const SizedBox(),
                            function: () async => await popup(context, "Ok",
                                confirmFunction: () => context
                                    .read<UserProvider>()
                                    .logOut(context),
                                description: '${txt(logoutMessage)}?')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      extendBodyBehindAppBar: false,
      appBar: appBar('Profile'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: context.bgcolor,
                                  borderRadius: BorderRadius.circular(80)),
                              child: profileIcon(size: 90),
                            ),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () async {
                                    // final file =await pickImage();
                                    // if (file == null) return;

                                    // await UserService.uploadUserImage(
                                    //     await UserService.uploadImage(
                                    //         File(file.path.toString()),
                                    //         folder: 'profile',
                                    //         type: file.extension.toString()));
                                  },
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    color:
                                        context.invertedColor.withOpacity(.7),
                                    size: 25,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                            onTap: () async {
                              // final file = await pickImage();
                              // if (file == null) return;

                              // await UserService.uploadUserBannere(
                              //     await UserService.uploadImage(
                              //         File(file.path.toString()),
                              //         folder: 'profile',
                              //         type: file.extension.toString()));
                            },
                            child: svgImage(edit, color: Colors.white)))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(context.currentUser.getFullName(), size: 20, bold: true),
                  const Gap(5),
                  Icon(
                    Icons.verified,
                    color: context.primaryColor,
                    size: 25,
                  )
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
