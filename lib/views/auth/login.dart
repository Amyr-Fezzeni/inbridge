// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/services/validators.dart';
import 'package:inbridge/views/auth/forget_password_screen.dart';
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
  TextEditingController passwordController = TextEditingController();
  bool passwordCorrect = false;
  FocusNode passwordFocus = FocusNode();
  bool isObscure = true;
  bool saveLogin = false;

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(context.w * .2),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                        .copyWith(right: 30),
                    child: Center(
                      child: Hero(
                        tag: 'logo',
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Image(image: AssetImage(logo), width: 180),
                            Txt(appName,
                                style: context.title.copyWith(
                                    color:
                                        context.invertedColor.withOpacity(.7))),
                            const Gap(10),
                            Txt("INSPIRE, CREATE, INNOVATE TO INFINITY ...",
                                color: context.invertedColor.withOpacity(.7))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(context.w * .1),
                  CustomTextField(
                      hint: txt('Email'),
                      controller: emailController,
                      validator: emailValidator,
                      isPassword: false,
                      leading: "assets/icons/profile_icon.png",
                      focus: emailFocus),
                  CustomTextField(
                      hint: txt('Password'),
                      controller: passwordController,
                      validator: passwordValidator,
                      leadingIcon: Icon(Icons.lock_outline_rounded,
                          size: 20,
                          color: context.invertedColor.withOpacity(.4)),
                      isPassword: true,
                      focus: passwordFocus),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(right: 5),
                          child: Checkbox(
                            value: saveLogin,
                            checkColor: Colors.white,
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 1.0, color: context.primaryColor),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: context.primaryColor),
                                borderRadius: BorderRadius.circular(4)),
                            activeColor: context.primaryColor,
                            onChanged: (bool? value) {
                              setState(() {
                                saveLogin = value ?? false;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: Txt(txt("Keep me logged in"), size: 13),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
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
                            text: txt("Login"),
                            w: double.infinity,
                            colors: [
                              context.primaryColor,
                              context.primaryColor
                            ],
                            function: () async {
                              final validateEmail =
                                  emailValidator(emailController.text);
                              if (validateEmail != null) {
                                popup(context, "Ok",
                                    cancel: false,
                                    title: txt("Worning"),
                                    description: validateEmail);
                                return;
                              }
                              final validatePassword =
                                  passwordValidator(passwordController.text);
                              if (validatePassword != null) {
                                popup(context, "Ok",
                                    cancel: false,
                                    title: txt("Worning"),
                                    description: validatePassword);
                                return;
                              }

                              context.userprovider.login(
                                  context,
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  saveLogin: saveLogin);
                            }),
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen())),
                        child: Text(
                          '${txt('Forgot password')} ?',
                          style: context.text.copyWith(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Gap(context.w * .1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
