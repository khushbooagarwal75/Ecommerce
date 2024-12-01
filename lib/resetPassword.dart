import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class ResetPasswordPage extends StatefulWidget {
  final String resetToken;

  ResetPasswordPage({required this.resetToken});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  PocketBaseAuthService auth = PocketBaseAuthService(PocketBase(getBaseUrl()));

  Future<void> resetPassword() async {
    // if (_formKey.currentState!.validate()) {
    //   final newPassword = _newPasswordController.text.trim();
    //   final confirmPassword = _confirmPasswordController.text.trim();
    //
    //   if (newPassword == confirmPassword) {
    //     try {
    //       // Call PocketBase to reset the password using the reset token
    //       await auth.resetPasswordWithToken(widget.resetToken, newPassword);
    //
    //       // Show success message
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Password has been successfully reset!'),
    //         backgroundColor: Colors.green,
    //       ));
    //
    //       // Navigate back to the login page or wherever appropriate
    //       Navigator.pop(context);
    //     } catch (error) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Failed to reset password: $error'),
    //         backgroundColor: Colors.red,
    //       ));
    //     }
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('Passwords do not match!'),
    //       backgroundColor: Colors.red,
    //     ));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _newPasswordController,
                hintText: 'Enter new password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                }, type: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.remove_red_eye),
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                type: TextInputType.visiblePassword,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                }, prefixIcon: Icon(Icons.remove_red_eye),
              ),
              SizedBox(height: 20),
              Custombutton(
                text: 'Submit',
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
