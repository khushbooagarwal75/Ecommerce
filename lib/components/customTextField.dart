import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,required this.controller,required this.hintText, this.isPassword= false,required this.type,required this.prefixIcon});
  TextEditingController controller;
  TextInputType type;
  Icon prefixIcon;
  String hintText;
  bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: isPassword!=false? Icon(Icons.remove_red_eye_outlined):null,
          filled: true,
          fillColor: Colors.grey.shade300.withOpacity(0.5),
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black,width: 1,),
              borderRadius: BorderRadius.circular(10)
          ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1,),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      keyboardType: type,
      obscureText: isPassword,
      obscuringCharacter: "*",
    );
  }
}
