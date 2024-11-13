import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

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
                   Image.asset("assets/images/fashionShop.png"),
                   Text(
                     "Choose Products",
                     style: TextStyle(
                       fontSize: 25,
                       fontWeight: FontWeight.w900,
                       color: Colors.black
                     ),),
                   Text("Stay ahead with the latest styles and trends! Discover \n   unique items and exclusive deals tailored just for \n           you.",style: TextStyle(
                       fontSize: 14,
                       color: Colors.grey
                   ),)
                 ],
            ),
          ),
        ));
  }
}
