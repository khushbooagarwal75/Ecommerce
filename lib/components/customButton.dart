import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),

          ),
        ),
        onPressed: (){
                onPressed();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(text,
                style:TextStyle(
                    color: Colors.white,
                    fontSize: 22
                )),
          ),
        ));
  }
}
