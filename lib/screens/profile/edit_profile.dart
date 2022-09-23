import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/user_provider.dart';
import '../../widgets/sheets/change_password.dart';
import '../../widgets/sc_button.dart';
import '../../widgets/sc_text.dart';
import '../../widgets/sc_textfield.dart';
import '../../widgets/sheets/image_picker_sheet.dart';

class EditProfile extends StatefulWidget {
  static const routeName = "/editProfile";
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> editProfileFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  String? gender;

  @override
  void initState() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    gender = userProvider.getUser.gender;
    emailController.text = userProvider.getUser.email;
    nameController.text = userProvider.getUser.name;
    phoneController.text = userProvider.getUser.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: ListView(padding: EdgeInsets.zero, children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const ScText(
                      "Edit Profile",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                      key: editProfileFormKey,
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            imagePickerSheet(context);
                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 40, top: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryLight,
                                borderRadius: BorderRadius.circular(60),
                                image: userProvider.getUser.image == ""
                                    ? null
                                    : DecorationImage(
                                        image: NetworkImage(
                                            userProvider.getUser.image))),
                            child: userProvider.getUser.image == ""
                                ? ScText(
                                    userProvider.getUser.name
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    color: Colors.white,
                                    size: 26)
                                : null,
                          ),
                        ),
                        ScTextField(
                          controller: nameController,
                          hintText: "Name *".toUpperCase(),
                          isPassword: false,
                          action: TextInputAction.next,
                          node: nameNode,
                          nextNode: phoneNode,
                        ),
                        const SizedBox(height: 20),
                        ScTextField(
                          controller: phoneController,
                          hintText: "Phone Number *".toUpperCase(),
                          isPassword: false,
                          action: TextInputAction.next,
                          node: phoneNode,
                          nextNode: emailNode,
                        ),
                        const SizedBox(height: 20),
                        ScTextField(
                          controller: emailController,
                          hintText: "Email *".toUpperCase(),
                          isPassword: false,
                          node: emailNode,
                          isEnabled: false,
                          type: TextInputType.emailAddress,
                        ),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 10, bottom: 6),
                            child: ScText("Select Gender",
                                color: primaryColor, weight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: 140,
                                child: RadioListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: const ScText("Male", size: 16),
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
                                  title: const ScText("Female", size: 16),
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
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                changePasswordSheet(context);
                              },
                              child: const ScText("Change Password",
                                  color: primaryColor,
                                  weight: FontWeight.bold,
                                  size: 14)),
                        ),
                        // Card(
                        //   elevation: 4,
                        //   child: SwButton(
                        //       text: "Change Password",
                        //       func: () {
                        //         changePasswordSheet(context);
                        //       },
                        //       color: Colors.white,
                        //       textColor: primaryColor,
                        //       isLoading: false),
                        // ),
                        //  const SizedBox(height: 16),
                        Card(
                            elevation: 4,
                            child: ScButton(
                                text: "Save Changes",
                                func: () {
                                  userProvider.updateUser(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      image: "",
                                      gender: gender,
                                      context: context);
                                },
                                isLoading: false))
                      ])))
            ])));
  }
}
