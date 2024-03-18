import 'package:flutter/material.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/settings/password%20&%20security/email/change_email.dart';
import 'package:inbridge/views/settings/password%20&%20security/password/change_password.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/loader.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar("Password & security", leading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            buildMenuTile(
                title: "Email",
                subtitle: "change your Email",
                icon: Icons.email_outlined,
                onClick: () => context.moveTo(const ChangeEmail())),
            buildMenuTile(
                title: "Password",
                subtitle: "change your password",
                icon: Icons.lock_outline_rounded,
                onClick: () => context.moveTo(const ChangePassword())),
            buildMenuTile(
                title: "Finger print",
                subtitle: "Use your finger print to login.",
                icon: Icons.fingerprint,
                onClick: () {}),
            buildMenuTile(
                title: "Log in history",
                subtitle: "Manage your logged in platforms",
                icon: Icons.manage_history_rounded,
                onClick: () {}),
          ],
        ),
      ),
    );
  }
}
