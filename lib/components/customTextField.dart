import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    required this.type,
    required this.prefixIcon,
    required this.validator,
    this.onTogglePasswordVisibility,
    this.isPasswordVisible = false,
  });

  final TextEditingController controller;
  final TextInputType type;
  final Icon prefixIcon;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final FormFieldValidator<String> validator;
  final VoidCallback? onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: isPassword
            ? GestureDetector(
          child: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onTap: onTogglePasswordVisibility,
        )
            : null,
        filled: true,
        fillColor: Colors.grey.shade300.withOpacity(0.5),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: type,
      obscureText: isPassword && !isPasswordVisible,
      obscuringCharacter: "*",
      validator: validator,


    );
  }
}
