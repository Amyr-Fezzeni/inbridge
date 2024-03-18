import 'package:flutter/material.dart';
import 'package:inbridge/providers/notification_provider.dart';
import 'package:inbridge/views/notifications/widgets/notification_body.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int count = context
        .watch<NotificationProvider>()
        .notifications
        .where((element) => !element.seen)
        .toList()
        .length;
    
    return Scaffold(
      backgroundColor: context.bgcolor,
      appBar: appBar("Notifications ${count > 0 ? "($count)" : ""}"),
      body:const  SizedBox(
        child: NotificationBody(),
      ),
    );
  }
}
