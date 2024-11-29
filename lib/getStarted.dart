import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/menu.dart';
import 'package:flutter/material.dart';

class Getstarted extends StatelessWidget {
  const Getstarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        fit: StackFit.expand,
        children: [
           Image.asset("assets/images/getStarted.png",fit: BoxFit.cover,),
           Positioned(
             bottom: 0,
               left: 0,
               right: 0,
               child: Container(
                 decoration: BoxDecoration(
                     gradient: LinearGradient(
                         end: const Alignment(0.0, -1),
                         begin: const Alignment(0.0, 0.6),
                         colors: [
                           Colors.black.withOpacity(0.5),
                           Colors.black.withOpacity(0.7),
                           Colors.transparent,
                         ],
                     )
                 ),
                 child: Column(
                   children: [
                     SizedBox(height: 40,),
                     Center(
                       child: Text("You want ",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 35,
                           fontWeight: FontWeight.w500,
                             letterSpacing: 1

                         ),),
                     ),
                     RichText(text: TextSpan(
                       children: [
                         TextSpan(text: " Authentic, here ",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 40,
                               fontWeight: FontWeight.w500,
                             letterSpacing: 1
                           ),),
                       ]
                     )),
                     Center(
                       child: Text("You go!",
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 40,
                             letterSpacing: 1,
                             fontWeight: FontWeight.w500

                         ),),
                     ),
                     Center(
                       child: Text("Find it here, buy it now!",
                         style: TextStyle(
                             color: Colors.white70,
                             fontSize: 14,
                             fontWeight: FontWeight.w500

                         ),),
                     ),
                     SizedBox(
                       height: 50,
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 64.0),
                       child: Custombutton(
                           text: "Get Started",
                           onPressed: () {
                             Navigator.pushReplacement(
                                 context, MaterialPageRoute(builder: (context) {
                                   return Menu();
                                 },));
                           },),
                     ),
                     SizedBox(
                       height: 40,
                     )

                   ],
                 ),
               )),
        ],
      ),
    );
  }
}
