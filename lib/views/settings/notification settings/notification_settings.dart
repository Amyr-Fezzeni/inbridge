import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/appbar.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar('Notification settings', leading: true),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            minVerticalPadding: 0,
            title: Txt("Notification",
                style: context.text.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Txt("",
                style: context.text.copyWith(
                    fontSize: 13,
                    color: context.invertedColor.withOpacity(.7))),
            trailing: CupertinoSwitch(
              value: context.currentUser.notificationStatus,
              onChanged: (value) {
                context.notificationProvider.updateNotificationStatus(value);
              },
            ),
          )
        ]),
      ),
    );
  }
}
