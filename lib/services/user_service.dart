// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../helpers/methods.dart';
import '../models/user_model.dart';
import '../screens/tabs.dart';

class UserService {
  Future<User> getUserDetails() async {
    print(headerApiMap);
    http.Response response =
        await http.get(headers: headerApiMap, Uri.parse("$baseUrl/user"));
    return User.fromSnap(jsonDecode(response.body)['data']);
  }

  Future loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      FocusScope.of(context).unfocus();
      http.Response response = await http.post(
          body: jsonEncode({"email": email, "password": password}),
          headers: headerApiMap,
          Uri.parse("$baseUrl/login"));
      if (response.statusCode == 200) {
        prefs
            .setString(tokenPref, jsonDecode(response.body)['data']["token"])
            .then((value) => Navigator.of(context)
                .pushNamedAndRemoveUntil(TabsScreen.routeName, (r) => true));
      }
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future createUser(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String gender,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      FocusScope.of(context).unfocus();
      http.Response response = await http.post(
          body: jsonEncode({
            "email": email,
            "password": password,
            "name": name,
            "phone": phone,
            "favourites": [],
            "image": "",
            "gender": gender
          }),
          headers: headerApiMap,
          Uri.parse("$baseUrl/register"));
      if (response.statusCode == 200) {
        prefs.setString(tokenPref, jsonDecode(response.body)['data']["token"]);
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      }

      // await http.post(
      //     headers: headerApiMap,
      //     body: jsonEncode(currentUser.toJson()),
      //     Uri.parse("$baseUrl/user"));
      //  await _ref.doc(credential.user!.uid).set(currentUser.toJson());
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  // Future forgotPassEmail(
  //     {required String email, required BuildContext context}) async {
  //   try {
  //     FocusScope.of(context).unfocus();
  //     await _auth.sendPasswordResetEmail(email: email);
  //     Navigator.of(context).pop();
  //     showSnack(
  //         context: context,
  //         message: 'Reset Password link sent on Email.',
  //         color: Colors.green);
  //   } catch (e) {
  //     showSnack(context: context, message: e.toString());
  //   }
  // }

  // Future<String?> changePassword(
  //     {required String currentPassword,
  //     required String newPassword,
  //     required BuildContext context}) async {
  //   final user = _auth.currentUser;
  //   final cred = EmailAuthProvider.credential(
  //       email: user!.email!, password: currentPassword);
  //   FocusScope.of(context).unfocus();

  //   try {
  //     await user.updatePassword(newPassword);
  //     Navigator.of(context).pop();
  //     showSnack(
  //         context: context,
  //         message: 'Password Changed Successfully.',
  //         color: Colors.green);
  //   } catch (e) {
  //     if (e == "wrong-password") {
  //       return 'Invalid Password';
  //     } else {
  //       return e.toString();
  //     }
  //   }
  //   return null;
  // }

  Future updateUserProfile(
      {String? name,
      String? phone,
      String? image,
      String? gender,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      Map body = {};
      if (name != null) {
        body["name"] = name;
      }
      if (phone != null) {
        body["phone"] = phone;
      }
      if (image != null) {
        body["image"] = image;
      }
      if (gender != null) {
        body["gender"] = gender;
      }
      await http.post(
          body: jsonEncode(body),
          headers: headerApiMap,
          Uri.parse("$baseUrl/user/update"));

      showSnack(
          context: context,
          message: 'Profile Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future updateUserProfilePicture(
      {File? image,
      required String userId,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/user/updateUserPicture"));
      final fileString = userId +
          image!.path.substring(image.path.lastIndexOf(".", image.path.length));
      final httpImage = await http.MultipartFile.fromPath(
          "userImage", image.path,
          filename: fileString);

      request.headers.addAll(headerApiMap);
      request.files.add(httpImage);
      request.send().then((response) {});
      showSnack(
          context: context,
          message: 'Profile Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future sendForgotEmail({required String email}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode({"email": email}),
        Uri.parse("$baseUrl/user/sendForgotEmail"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future forgotPassword(
      {required String email, required String newPassword}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode({"email": email, "newPassword": newPassword}),
        Uri.parse("$baseUrl/user/forgotPassword"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future resetPassword(
      {required String oldPassword, required String newPassword}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(
            {"oldPassword": oldPassword, "newPassword": newPassword}),
        Uri.parse("$baseUrl/user/resetPassword"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future rateProduct({required Map rating}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(rating),
        Uri.parse("$baseUrl/user/rate"));
    if (response.statusCode == 200) {
      return true;
    }
  }
}
