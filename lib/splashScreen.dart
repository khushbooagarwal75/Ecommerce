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

    // Introduce a 2-second delay before navigating
    await Future.delayed(Duration(seconds: 2));

    // Navigate based on login status
    if (newuser) {
      // If user is logged in, go to the Home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Menu()),
      );
    } else {
      // If user is not logged in, show the onboarding page
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
        // color: const Color.fromARGB(255, 224, 24, 24),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            color: Colors.red,
          ), // Your splash screen image
        ),
      ),
    );
  }
}
