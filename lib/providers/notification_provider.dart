import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/models/notification/notification.dart';
import 'package:inbridge/services/shared_data.dart';
import 'package:inbridge/services/user_service.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/navigation_service.dart';

class NotificationProvider with ChangeNotifier{
  Stream<QuerySnapshot<Map<String, dynamic>>>? notificationStream;
  List<Notif> notifications = [];
  bool isNotificationActive = true;

  getNotificationStatus() {
    isNotificationActive = DataPrefrences.getNotification();
  }

  changeNoticationStatus(bool value) {
    DataPrefrences.setNotification(value);
    getNotificationStatus();
    if (value) {
      UserService.saveFcm(NavigationService.navigatorKey.currentContext!.userId);
    } else {
      UserService.removeFcm(NavigationService.navigatorKey.currentContext!.userId);
    }
  }

  startNotificationsListen() {
    if (notificationStream != null) return;
    notificationStream = FirebaseFirestore.instance
        .collection("notifications")
        .where('to', isEqualTo: NavigationService.navigatorKey.currentContext!.userId)
        .snapshots();
    notificationStream?.listen((event) {}).onData((data) {
      notifications =
          List<Notif>.from(data.docs.map((e) => Notif.fromMap(e.data())));
      notifyListeners();
    });
  }

    updateNotificationStatus(bool value) async {
    UserService.setNotificationSetting(value);
  }


  removeNotificationStream() async {
    if (notificationStream == null) return;
    notificationStream?.listen((event) {}).cancel();
    notificationStream = null;
  }

}