import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_client/screens/address.dart';
import 'package:services_client/screens/profile/help_support.dart';
import 'package:services_client/screens/profile/terms_conditions.dart';

const String tokenPref = "AUTH_TOKEN";

const String baseUrl = "http://192.168.1.7:5000/api";
const String uploadUrl = "http://192.168.1.7:5000/uploads";

Map<String, String> headerApiMap = {
  "Content-Type": "application/json; charset=utf-8",
  "Accept": "*/*"
};

const Color primaryColor = Color(0xFF495C83);
const Color primaryLight = Color(0xFF7A86B6);
const Color secondaryColor = Color(0xFFA8A4CE);
const Color secondaryLight = Color(0xFFC8B6E2);

LinearGradient appGradient = LinearGradient(
    colors: [primaryLight, primaryLight.withOpacity(.5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

InputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);
InputBorder errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
  borderRadius: BorderRadius.circular(0),
);

const List profileItems = [
  {
    "name": "Address",
    "route": AddressScreen.routeName,
    "icon": CupertinoIcons.map
  },
  {
    "name": "Help and Support",
    "route": HelpSupport.routeName,
    "icon": CupertinoIcons.info
  },
  {
    "name": "Terms and Conditions",
    "route": TermsConditions.routeName,
    "icon": CupertinoIcons.doc
  },
  {
    "name": "Logout",
    //  "route": AddressScreen.routeName,
    "icon": CupertinoIcons.person_badge_minus
  }
];
List<Map<String, String>> servicesList = [
  {"image": "assets/images/cleaning.png", "name": "Coding"},
  {"image": "assets/images/car_wash.png", "name": "Driving"},
  {"image": "assets/images/haircut.png", "name": "Hair for Him"},
  {"image": "assets/images/haircut.png", "name": "Hair for Her"},
  {"image": "assets/images/massage.png", "name": "Spa for Him"},
  {"image": "assets/images/massage.png", "name": "Spa for her"},
  {"image": "assets/images/cooking.jpg", "name": "Cooking"},
];
