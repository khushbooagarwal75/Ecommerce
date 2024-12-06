import 'package:ecommerce_app/menu.dart';
import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/onBoard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late SharedPreferences sp;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_value_login();
  }

  void check_value_login() async {
    sp = await SharedPreferences.getInstance();
    newuser = (sp.getBool('isLoggedIn') ?? false);

    await Future.delayed(Duration(seconds: 2));

    if (newuser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Menu()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
