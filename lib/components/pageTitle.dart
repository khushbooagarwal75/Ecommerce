import 'package:flutter/material.dart';

class Pagetitle extends StatelessWidget {
  const Pagetitle({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text1 \n$text2",
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 34,
      ),
    );
  }
}
