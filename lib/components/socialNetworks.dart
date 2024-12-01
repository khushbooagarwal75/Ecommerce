import 'package:flutter/material.dart';

class Socialnetworks extends StatelessWidget {
  const Socialnetworks(
      {super.key,
      required this.onPressed,
      required this.text1,
      required this.text2});
  final String text1;
  final String text2;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "- OR Continue with -",
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor:
                    const Color.fromARGB(255, 19, 6, 5).withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset("assets/images/facebook.png"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor:
                    const Color.fromARGB(255, 19, 6, 5).withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset("assets/images/gmail.png"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.red.shade300),
                color: Colors.transparent,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor:
                    const Color.fromARGB(255, 19, 6, 5).withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset("assets/images/apple-logo.png"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            onPressed();
          },
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: text1,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
            TextSpan(
                text: text2,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                    decoration: TextDecoration.underline)),
          ])),
        )
      ],
    );
  }
}
