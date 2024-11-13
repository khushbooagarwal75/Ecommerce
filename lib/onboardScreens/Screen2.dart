import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/SalesConsulting.png"),
                Text("Make Payment",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                  ),),
                Text("Enjoy quick , secure payment options for all your \n     purchases. Your favorite items are just \n        a tap away!",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                  ),)
              ],
            ),
          ),
        ));
  }
}
