import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inbridge/providers/menu_provider.dart';
import 'package:inbridge/providers/notification_provider.dart';
import 'package:inbridge/providers/theme_notifier.dart';
import 'package:inbridge/providers/user_provider.dart';
import 'package:inbridge/services/shared_data.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/navigation_service.dart';
import 'package:inbridge/views/splash%20screen/custom_splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await DataPrefrences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InBridge',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
              .copyWith(background: context.bgcolor)),
      home: const CustomSplashScreen(),
    );
  }
}
