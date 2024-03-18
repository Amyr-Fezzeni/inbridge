import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/settings/contact%20info/edit%20profile/phone/change_phone.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/loader.dart';
import '../../../services/util/language.dart';
import 'edit profile/name/change_name.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.bgcolor,
        appBar: appBar('Contact info'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const Gap(30),
              buildMenuTile(
                  title:
                      "${context.currentUser.firstName} ${context.currentUser.lastName}",
                  subtitle: "Your display name",
                  icon: Icons.person,
                  onClick: () => context.moveTo(const ChangeName())),
              buildMenuTile(
                  title: context.currentUser.phoneNumber.isEmpty
                      ? txt('Set up your phone number')
                      : context.currentUser.phoneNumber,
                  subtitle: context.currentUser.phoneNumber.isEmpty
                      ? ''
                      : "Your Phone number",
                  icon: Icons.phone,
                  onClick: () => context.moveTo(const ChangePhone())),
             
            ])));
  }
}
