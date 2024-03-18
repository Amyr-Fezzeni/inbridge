// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/providers/menu_provider.dart';
import 'package:inbridge/providers/notification_provider.dart';
import 'package:inbridge/views/splash%20screen/custom_splash_screen.dart';
import 'package:provider/provider.dart';
import '../constants/fixed_messages.dart';
import '../models/notification/notification.dart';
import '../models/user.dart';
import '../services/util/language.dart';
import '../services/util/logic_service.dart';
import '../services/util/navigation_service.dart';
import '../services/notification_service.dart';
import '../services/shared_data.dart';
import '../services/user_service.dart';
import '../services/validators.dart';
import '../views/structure_home.dart';
import '../views/widgets/popup.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  LanguageModel currentLanguage = LanguageModel.french;

  setDefaultLanguage(LanguageModel code) {
    currentLanguage = code;
    DataPrefrences.setDefaultLanguage(code.name);
    notifyListeners();
  }

  bool isLoading = false;

  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;

  startUserListen(String userId) {
    if (userStream != null) return;
    userStream =
        UserService.userCollection.where("id", isEqualTo: userId).snapshots();
    userStream?.listen((event) {}).onData((data) async {
      currentUser = UserModel.fromMap(data.docChanges.first.doc.data()!);
      notifyListeners();
    
    });
  }

  stopUserListen() {
    if (userStream == null) return;
    userStream?.listen((event) {}).cancel();
    userStream = null;
  }

  Future<void> removeData() async {
    await UserService.removeFcm(currentUser!);
    await UserService.connectStatus(true);
    NavigationService.navigatorKey.currentContext!
        .read<NotificationProvider>()
        .removeNotificationStream();

    stopUserListen();
    currentUser = null;
    DataPrefrences.setLogin("");
    DataPrefrences.setPassword("");
  }

  // login & signup
  Future<void> logOut(context) async {
    await removeData();
    NavigationService.navigatorKey.currentContext!.read<MenuProvider>().init();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const CustomSplashScreen()),
        (Route<dynamic> route) => false);
    // Navigator.pushReplacement(NavigationService.navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (_) => const Index()));
  }

  Future<void> login(context, String email, String password,
      {required bool saveLogin}) async {
    isLoading = true;
    notifyListeners();

    var u = await UserService.getUser(email, password);
    isLoading = false;
    notifyListeners();

    if (u != null) {
      currentUser = u;
      startUserListen(u.id);
      NavigationService.navigatorKey.currentContext!
          .read<NotificationProvider>()
          .startNotificationsListen();
      if (saveLogin) {
        DataPrefrences.setLogin(email);
        DataPrefrences.setPassword(password);
      }
      await UserService.saveFcm(u);

      log("connected");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const StructureHomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      popup(context, "Ok", cancel: false, description: txt(loginError2));
    }
  }

  Future<bool> checkLogin() async {

    if (DataPrefrences.getLogin().isEmpty) return false;
    var u = await UserService.getUser(
        DataPrefrences.getLogin(), DataPrefrences.getPassword());

    if (u != null) {
      currentUser = u;
      startUserListen(u.id);
      NavigationService.navigatorKey.currentContext!
          .read<NotificationProvider>()
          .startNotificationsListen();
      UserService.saveFcm(u);
      UserService.connectStatus(true);
      log("connected");
      Navigator.of(NavigationService.navigatorKey.currentContext!)
          .pushAndRemoveUntil(PageTransition(const StructureHomeScreen()),
              (Route<dynamic> route) => false);
      return true;
    } else {
      return false;
    }
  }

  Future<void> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required UserRole role,
      String photo = ""}) async {
    isLoading = true;
    notifyListeners();
    isLoading = false;
    UserModel user = UserModel(
        id: generateId(),
        firstName: firstName,
        lastName: lastName,
        role: role,
        email: email.toLowerCase().trim(),
        phoneNumber: '',
        photo: photo,
        banner: '',
        jobs: [],
        dateCreated: DateTime.now(),
        lastLoggedIn: DateTime.now(),
        emailVerified: false,
        status: UserStatus.active,
        savedJobs: [],
        notifications: allNotifications,
        password: password);
    var u = await UserService.addUser(user);
    if (u == "true") {
      var u = await UserService.getUser(user.email, user.password);
      if (u != null) {
        currentUser = u;
        startUserListen(u.id);
        NavigationService.navigatorKey.currentContext!
            .read<NotificationProvider>()
            .startNotificationsListen();
        UserService.saveFcm(user);
        DataPrefrences.setLogin(email);
        DataPrefrences.setPassword(password);
        UserService.connectStatus(true);
        NotificationService.sendPushNotifications(
            title: appName,
            body: welcomeMessage,
            token: currentUser!.id,
            type: 'system',
            userId: currentUser!.id,
            role: "user");
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const StructureHomeScreen()),
                (Route<dynamic> route) => false);
      }
    } else {
      popup(NavigationService.navigatorKey.currentContext!, 'ok',
          cancel: false, description: txt(signupError));
    }
  }


  Future<void> changePassword(BuildContext context, String oldPassword,
      String newPassword, String newPasswordConfirmed) async {
    final validate = passwordValidator(newPassword);
    if (validate != null) {
      await popup(context, "Ok", cancel: false, description: txt(validate));
      return;
    }
    if (newPasswordConfirmed.isEmpty || newPassword.isEmpty) {
      await popup(context, "Ok", cancel: false, description: txt(passError1));
      return;
    }
    if (newPasswordConfirmed != newPassword) {
      await popup(context, "Ok", cancel: false, description: txt(passError2));
      return;
    }
    if (oldPassword != currentUser?.password) {
      await popup(context, "Ok", cancel: false, description: txt(passError3));
      return;
    }

    bool result =
        await UserService.changePassword(currentUser!.id, newPassword);

    if (result) {
      DataPrefrences.setPassword(newPassword);
      await popup(context, "Ok", cancel: false, description: txt(passSuccess));
    } else {
      await popup(context, "Ok", cancel: false, description: txt(defaultError));
    }

    Navigator.pop(context);
  }

  Future<bool> changePhoneNumber(String phone) async {
    bool result = await UserService.changePhoneNumber(currentUser!, phone);
    // updateUser();
    return result;
  }

  changeName(BuildContext context, String name, String lastName) async {
    currentUser!.firstName = name;
    currentUser!.lastName = lastName;

    bool result = await UserService.changeName(currentUser!);
    if (result) {
      await popup(context, "Ok",
          cancel: false, description: "${txt(nameSuccess)}.");
    } else {
      await popup(context, "Ok",
          cancel: false, description: "${txt(defaultError)}.");
    }
    Navigator.pop(context);
    // updateUser();
  }

  changeEmail(BuildContext context, String email) async {
    currentUser!.email = email;
    final validator = emailValidator(email);
    if (validator != null) {
      popup(context, "Ok", cancel: false, description: validator);
      return;
    }
    bool result = await UserService.changeEmail(currentUser!, email);
    if (result) {
      await popup(context, "Ok",
          cancel: false, description: "${txt(emailSuccess)}.");
      Navigator.pop(context);
    } else {
      await popup(context, "Ok",
          cancel: false, description: "${txt(emailError)}.");
    }

    // updateUser();
  }


}
