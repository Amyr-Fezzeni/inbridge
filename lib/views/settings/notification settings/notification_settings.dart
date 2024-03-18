import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/models/notification/notification.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/services/util/logic_service.dart';
import 'package:inbridge/views/widgets/appbar.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    Widget card(NotificationSetting notif) => Container(
          // color: Colors.amber,
          margin: const EdgeInsets.only(top: 5),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            minVerticalPadding: 0,
            title: Txt(capitalize(notif.title.name),
                style: context.text.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Txt(notif.description,
                style: context.text.copyWith(
                    fontSize: 13,
                    color: context.invertedColor.withOpacity(.7))),
            trailing: CupertinoSwitch(
              value: notif.isActivated,
              onChanged: (value) {
                var lst = context.userprovider.currentUser!.notifications;
                int index = lst.indexOf(notif);
                lst.removeAt(index);
                notif.isActivated = value;
                lst.insert(index, notif);
                context.notificationProvider.updateNotifications(lst);
              },
            ),
          ),
        );
    log(context.userprovider.currentUser!.notifications.toString());
    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar('Notification settings', leading: true),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children:
              context.currentUser.notifications.map((e) => card(e)).toList(),
        ),
      ),
    );
  }
}
