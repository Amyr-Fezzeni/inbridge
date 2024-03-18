import 'package:flutter/material.dart';
import 'package:inbridge/constants/fixed_messages.dart';
import 'package:inbridge/providers/user_provider.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/services/validators.dart';
import 'package:inbridge/views/auth/forget_password_screen.dart';
import 'package:inbridge/views/widgets/bottuns.dart';
import 'package:inbridge/views/widgets/text_field.dart';
import 'package:inbridge/views/widgets/loader.dart';
import 'package:inbridge/views/widgets/popup.dart';
import 'package:provider/provider.dart';

class ContinueLogInScreen extends StatefulWidget {
  final String email;
  const ContinueLogInScreen({super.key, required this.email});

  @override
  State<ContinueLogInScreen> createState() => _ContinueLogInScreenState();
}

class _ContinueLogInScreenState extends State<ContinueLogInScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool passwordCorrect = false;
  FocusNode passwordFocus = FocusNode();
  bool isObscure = true;
  bool keepLoging = false;

  @override
  Widget build(BuildContext context) {
    // var lang = context.read<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: logoWidget()),
        leading: const SizedBox(),
        backgroundColor: context.bgcolor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: context.bgcolor,
      body: SizedBox(
        height: context.h,
        width: context.w,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Txt('Welcome', style: context.title.copyWith(fontSize: 24)),
                  const SizedBox(
                    height: 10,
                  ),
                  Txt(widget.email),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      hint: txt('Password'),
                      controller: passwordController,
                      validator: passwordValidator,
                      leading: "assets/icons/profile_icon.png",
                      isPassword: true,
                      focus: passwordFocus),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(right: 5),
                          child: Checkbox(
                            value: keepLoging,
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
                                keepLoging = value ?? false;
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
                  const SizedBox(
                    height: 20,
                  ),
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
                            text: txt("Log in"),
                            w: double.infinity,
                            colors: [
                              context.primaryColor,
                              context.primaryColor
                            ],
                            function: () async {
                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate() &&
                                  widget.email.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                context.read<UserProvider>().login(context,
                                    widget.email, passwordController.text,
                                    saveLogin: keepLoging);
                              } else {
                                popup(context, "Ok",
                                    cancel: false,
                                    title: txt("Worning"),
                                    description: txt(loginError1));
                              }
                            }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen())),
                            child: Text(
                              '${txt('Forgot password')} ?',
                              style: context.text.copyWith(
                                  fontSize: 15, color: context.primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              '${txt('Not you')} ?',
                              style: context.text.copyWith(
                                  fontSize: 15, color: context.primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
