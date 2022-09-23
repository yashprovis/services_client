import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/user_service.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_scaffold.dart';
import '../widgets/sc_text.dart';
import '../widgets/sc_textfield.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> registerFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  String? gender;
  bool isLoading = false;
  bool isChecked = false;
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
                          // onTap: () => Navigator.of(context)
                          //     .pushReplacementNamed(TabsScreen.routeName),
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
                      //  height: MediaQuery.of(context).size.height - 266,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      margin: const EdgeInsets.only(
                        top: 80,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 30),
                              child: const ScText(
                                "REGISTER",
                                // color: Colors.white,
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Form(
                              key: registerFormKey,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 360,
                                child: ListView(
                                  padding: EdgeInsets.only(
                                      bottom: 20 +
                                          MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                      top: 30),
                                  shrinkWrap: true,
                                  children: [
                                    ScTextField(
                                      controller: nameController,
                                      hintText: "Name *".toUpperCase(),
                                      isPassword: false,
                                      action: TextInputAction.next,
                                      node: nameNode,
                                      nextNode: phoneNode,
                                    ),
                                    const SizedBox(height: 16),
                                    ScTextField(
                                      controller: phoneController,
                                      hintText: "Phone Number *".toUpperCase(),
                                      isPassword: false,
                                      action: TextInputAction.next,
                                      node: phoneNode,
                                      nextNode: emailNode,
                                    ),
                                    const SizedBox(height: 16),
                                    ScTextField(
                                      controller: emailController,
                                      hintText: "Email *".toUpperCase(),
                                      isPassword: false,
                                      action: TextInputAction.next,
                                      node: emailNode,
                                      nextNode: passwordNode,
                                      type: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    ScTextField(
                                      controller: passwordController,
                                      hintText: "Password *".toUpperCase(),
                                      isPassword: true,
                                      node: passwordNode,
                                    ),
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      child: ScText("Select Gender",
                                          color: primaryColor,
                                          weight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 140,
                                            child: RadioListTile(
                                              dense: true,
                                              contentPadding: EdgeInsets.zero,
                                              title: const ScText("Male",
                                                  size: 16),
                                              value: "male",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                });
                                              },
                                            )),
                                        SizedBox(
                                            width: 140,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              title: const ScText("Female",
                                                  size: 16),
                                              value: "female",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                });
                                              },
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    ScButton(
                                        isLoading: isLoading,
                                        text: "REGISTER",
                                        func: () {
                                          if (registerFormKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            try {
                                              UserService().createUser(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  gender: gender!,
                                                  context: context);
                                            } catch (e) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          }
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 80,
                                              color: Colors.black,
                                              height: 1),
                                          const ScText(
                                            "   OR   ",
                                            size: 14,
                                          ),
                                          Container(
                                              width: 80,
                                              color: Colors.black,
                                              height: 1)
                                        ],
                                      ),
                                    ),
                                    TextButton.icon(
                                        onPressed: () => Navigator.of(context)
                                            .pushReplacementNamed(
                                                LoginScreen.routeName),
                                        icon: const Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        label: const ScText("SIGN IN"))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      //   ],
                      // ),
                      ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 60),
                      child: SizedBox(
                          height: 180,
                          child: Image.asset("assets/images/massage.png")),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
