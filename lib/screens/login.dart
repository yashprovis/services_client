import 'package:flutter/material.dart';

import 'package:services_client/screens/register.dart';
import 'package:services_client/screens/tabs.dart';

import '../services/user_service.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_scaffold.dart';
import '../widgets/sc_text.dart';
import '../widgets/sc_textfield.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ScScaffold(
        body: SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50, right: 20),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(TabsScreen.routeName),
                      child: const ScText(
                        "SKIP",
                        size: 14,
                        // color: Colors.white,
                      )))),
          SizedBox(
              height: 120,
              child: Hero(
                  tag: "logo-shift",
                  child: Image.asset("assets/images/logo.png"))),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 266,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                margin: const EdgeInsets.only(top: 80),
                padding: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    key: loginFormKey,
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 20),
                      shrinkWrap: true,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 50, top: 30),
                          child: const ScText(
                            "SIGN IN",
                            // color: Colors.white,
                            size: 20,
                            weight: FontWeight.w500,
                          ),
                        ),
                        ScTextField(
                          controller: emailController,
                          hintText: "EMAIL *",
                          isPassword: false,
                          action: TextInputAction.next,
                          node: emailNode,
                          nextNode: passwordNode,
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        ScTextField(
                          controller: passwordController,
                          isPassword: true,
                          node: passwordNode,
                          hintText: "PASSWORD *",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ForgotPasswordScreen.routeName);
                            },
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text('Forgot Password?',
                                    style: TextStyle(
                                        height: 1,
                                        fontWeight: FontWeight.w300,
                                        //color: Colors.white,
                                        fontSize: 14))),
                          ),
                        ),
                        ScButton(
                            isLoading: isLoading,
                            text: "SIGN IN",
                            func: () async {
                              if (loginFormKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  UserService().loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                } catch (e) {}
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 80, color: Colors.black, height: 1),
                              const ScText("   OR   ",
                                  size: 14, color: Colors.black),
                              Container(
                                  width: 80, color: Colors.black, height: 1)
                            ],
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed(
                                      RegisterScreen.routeName),
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                              label: const ScText(
                                "Create Account",
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    height: 180,
                    child: Image.asset("assets/images/cleaning.png")),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
