// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:inbridge/constants/fixed_messages.dart';
import 'package:inbridge/services/validators.dart';
import 'package:inbridge/views/auth/continue_login.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/views/widgets/text_field.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:inbridge/constants/constants.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/popup.dart';
import '../../../../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool emailCorrect = false;
  FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // var lang = context.read<LanguageProvider>();
    return Scaffold(
      backgroundColor: context.bgcolor,
      // appBar: appBar('Les inbridges', leading: false),
      body: SizedBox(
        // color: Colors.context.primaryColorGrey,
        height: context.h,
        width: context.w,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(right: 30),
                  // color: const Color.fromARGB(255, 57, 111, 176),
                  child: Center(
                    child: Hero(
                      tag: 'logo',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                              image: AssetImage('assets/icons/logo1.png'),
                              width: 100),
                          Txt('Les inbridges'.toUpperCase(),
                              style: context.title.copyWith(
                                  color: context.invertedColor.withOpacity(.7)))
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CustomTextField(
                    hint: txt('Email'),
                    controller: emailController,
                    validator: emailValidator,
                    isPassword: false,
                    leading: "assets/icons/profile_icon.png",
                    focus: emailFocus),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: context.watch<UserProvider>().isLoading
                      ? Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(80)),
                            child: cLoader(),
                          ),
                        )
                      : gradientButton(
                          text: txt("Continue with Email"),
                          w: double.infinity,
                          colors: [context.primaryColor, context.primaryColor],
                          function: () async {
                            if (formkey.currentState != null &&
                                formkey.currentState!.validate() &&
                                emailController.text.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContinueLogInScreen(
                                          email: emailController.text)));
                            } else {
                              popup(context, "Ok",
                                  cancel: false,
                                  title: txt("Worning"),
                                  description: txt(loginError1));
                            }
                          }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: context.invertedColor.withOpacity(.4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          txt('Or'),
                          style: context.text,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: context.invertedColor.withOpacity(.4),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      socialMediaButton(
                          function: () =>{},
                              // context.read<UserProvider>().googleLogIn(context),
                          text: txt("Login with Google"),
                          image: googleLogo),
               
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          // width: context.w * .4,
                          color: context.invertedColor.withOpacity(.4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Txt(
                          '${txt("Don't have an account")} ?',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          // width: context.w * .4,
                          color: context.invertedColor.withOpacity(.4),
                        ),
                      ),
                    ],
                  ),
                ),
                // Center(
                //   child: borderButton('Sign Up',
                //       w: 100,
                //       function: () =>
                //        Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   const RoleSelectionScreen()))),
                // ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
