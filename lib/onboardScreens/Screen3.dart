import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

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
                Image.asset("assets/images/ShoppingBag.png"),
                Text("Get Your Order",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                  ),),
                Text("Fast and reliable delivery straight to your door! Track \n    your orders in real-time and enjoy seamless, \n       worry-free shopping.",
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
