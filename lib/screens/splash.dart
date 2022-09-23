import 'package:flutter/material.dart';
import 'package:services_client/screens/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/sc_scaffold.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(tokenPref) && prefs.getString(tokenPref) != "") {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName));
    } else {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScScaffold(
        body: Center(
      child: Hero(
          tag: "logo-shift",
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.white,
          )),
    ));
  }
}
