// import 'package:flutter/material.dart';
// import 'package:pigiste/constants/style.dart';
// import 'package:pigiste/providers/theme_notifier.dart';
// import 'package:pigiste/services/language.dart';
// import 'package:pigiste/views/auth/login.dart';
// import 'package:pigiste/services/ext.dart';
// import 'package:provider/provider.dart';

// class PigisteStartedWidget extends StatefulWidget {
//   const PigisteStartedWidget({super.key});

//   @override
//   State<PigisteStartedWidget> createState() => _PigisteStartedWidgetState();
// }

// class _PigisteStartedWidgetState extends State<PigisteStartedWidget> {
//   late PageController _pageController;
//   // double _progress;
//   @override
//   void initState() {
//     _pageController = PageController()
//       ..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double progress =
//         _pageController.hasClients ? (_pageController.page ?? 0) : 0;
//     var style = context.watch<ThemeNotifier>();
//     double defaultHeight = 400;
//     return SizedBox(
//       // color: Colors.amber,
//       height: context.h * progress < defaultHeight
//           ? defaultHeight
//           : context.h * progress,
//       child: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   txt("Les Pigistes"),
//                   style: style.title,
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Txt("", size: 18),
//                 const Spacer(),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Opacity(
//                     opacity: 1 - progress,
//                     child: GestureDetector(
//                       onTap: () {
//                         if (_pageController.page == 0) {
//                           _pageController.animateToPage(1,
//                               duration: const Duration(milliseconds: 400),
//                               curve: Curves.ease);
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 10),
//                         margin: const EdgeInsets.only(bottom: 30),
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomLeft,
//                             end: Alignment.topRight,
//                             // stops: [0.4, 0.8],
//                             colors: primaryGradient,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Txt("Get Started", color: Colors.white),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             const Icon(
//                               Icons.chevron_right,
//                               size: 24,
//                               color: Colors.white,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const LoginScreen(),
//         ],
//       ),
//     );
//   }
// }
