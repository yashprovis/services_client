import 'package:flutter/material.dart';
import 'package:services_client/helpers/methods.dart';
import 'package:services_client/screens/new_password.dart';

import '../constants.dart';
import '../services/user_service.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_text.dart';
import '../widgets/sc_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/forgot-password";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> forgotPassFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  String actualOtp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: primaryLight,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              padding: const EdgeInsets.only(bottom: 20, top: 30),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 120,
                              child: (Hero(
                                  tag: "logo-shift",
                                  child:
                                      Image.asset("assets/images/logo.png")))),
                          const SizedBox(height: 10),
                          const ScText(
                            "FORGOT PASSWORD",
                            color: Colors.white,
                            size: 20,
                            weight: FontWeight.w300,
                          )
                        ],
                      )),
                  Positioned(
                      left: 20,
                      top: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            // ListView(
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //   children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: forgotPassFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: ScText(
                          actualOtp.isEmpty
                              ? "Please provide your account email address to receive a code on the email to reset your password."
                              : "Enter the OTP sent to your account email address.",
                          weight: FontWeight.w300,
                          size: 14),
                    ),
                    const SizedBox(height: 20),
                    ScTextField(
                      controller: emailController,
                      hintText: "Email ",
                      isPassword: false,
                      isEnabled: actualOtp.isEmpty ? true : false,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: actualOtp.isNotEmpty ? 20 : 10),
                    actualOtp.isNotEmpty
                        ? ScTextField(
                            controller: otpController,
                            hintText: "OTP ",
                            isPassword: false,
                            type: TextInputType.phone,
                          )
                        : SizedBox(),
                    const SizedBox(height: 20),
                    ScButton(
                        isLoading: isLoading,
                        text: actualOtp.isNotEmpty ? "Submit" : "Send OTP",
                        func: () async {
                          if (actualOtp.isNotEmpty) {
                            if (otpController.text.trim().isNotEmpty) {
                              if (otpController.text == actualOtp) {
                                Navigator.of(context).pushReplacementNamed(
                                    NewPasswordScreen.routeName,
                                    arguments: emailController.text.trim());
                              } else {
                                showSnack(
                                    context: context,
                                    message: "Incorrect Otp",
                                    color: Colors.red);
                              }
                            } else {
                              showSnack(
                                  context: context,
                                  message: "Otp cannot be empty",
                                  color: Colors.red);
                            }
                          } else {
                            if (emailController.text.trim().isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              FocusScope.of(context).unfocus();
                              var data = await UserService().sendForgotEmail(
                                  email: emailController.text.trim());
                              if (data != null && data is Map) {
                                actualOtp = data["otp"];
                                showSnack(
                                    context: context,
                                    message:
                                        "Otp sent successfully to your email",
                                    color: Colors.green);
                              } else if (data != null && data is String) {
                                showSnack(
                                    context: context,
                                    message: data,
                                    color: Colors.red);
                              } else {
                                showSnack(
                                    context: context,
                                    message: "Request Failed. Try again later.",
                                    color: Colors.red);
                              }
                              isLoading = false;
                              setState(() {});
                            } else {
                              showSnack(
                                  context: context,
                                  message: "Email cannot be empty",
                                  color: Colors.red);
                            }
                          }
                        }),
                  ],
                ),
              ),
            )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
