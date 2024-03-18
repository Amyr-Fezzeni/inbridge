// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:pigiste/constants/style.dart';
// import 'package:pigiste/views/started%20screen/components/mymizze_started_widget.dart';
// import 'package:provider/provider.dart';

// import '../../constants/constants.dart';
// import '../../providers/theme_notifier.dart';
// import '../../providers/user_provider.dart';
// import '../../services/shared_data.dart';
// import 'package:pigiste/services/ext.dart';

// class PigisteStartedScreen extends StatefulWidget {
//   const PigisteStartedScreen({super.key});

//   @override
//   State<PigisteStartedScreen> createState() => _PigisteStartedScreenState();
// }

// class _PigisteStartedScreenState extends State<PigisteStartedScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // checkLogin();
//   }

//   void checkLogin() {
//     Future.delayed(const Duration(milliseconds: 50)).then((value) {
//       context.read<ThemeNotifier>().initTheme(DataPrefrences.getDarkMode());
//       context
//           .read<UserProvider>()
//           .setDefaultLanguage(DataPrefrences.getDefaultLanguage());
//       // if (DataPrefrences.getPrivecy() == false ||
//       //     DataPrefrences.getTerms() == false) {
//       //   Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
//       //       Navigator.pushReplacement(context,
//       //           MaterialPageRoute(builder: (context) => const PopUpPrivecy())));
//       //   return;
//       // } else {
//       // log("Shared prefrences :${DataPrefrences.getAccountType()}, ${DataPrefrences.getLogin()}, ${DataPrefrences.getPassword()}");
//       if (DataPrefrences.getLogin().isNotEmpty &&
//           DataPrefrences.getPassword().isNotEmpty) {
//         context.read<UserProvider>().checkLogin().then((value) {
//           // log('value login ? $value');
//           if (!value) {
//             FlutterNativeSplash.remove();
//           }
//         });
//       } else {
//         FlutterNativeSplash.remove();
//       }
//     });

//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.bgcolor,
//       body: SizedBox(
//         height: context.h,
//         child: Stack(
//           children: [
//             Container(
//               height: context.h,
//               width: context.w,
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                 colors: secondGradient,
//               )),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     // margin: const EdgeInsets.only(top: 80, bottom: 10),
//                     // color: const Color.fromARGB(255, 57, 111, 176),
//                     height: context.h - 350,
//                     // color: Colors.amber,
//                     child: const Center(
//                       child: Image(
//                         image: AssetImage(logo),
//                         height: 200,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // if (1 > 2)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 // height: context.h * .6,
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25),
//                     ),
//                     color: lightBgColor),
//                 child: const PigisteStartedWidget(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
