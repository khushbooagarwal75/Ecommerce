import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class Forgotpassword extends StatelessWidget {
  TextEditingController email=TextEditingController();
  PocketBaseAuthService auth=PocketBaseAuthService(PocketBase(getBaseUrl()));
  final _formKey = GlobalKey<FormState>();
  Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Pagetitle(
                    text1: "Forgot ",
                    text2: "password?"),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        type: TextInputType.emailAddress,
                        controller: email,
                        hintText: "Enter your Email Address",
                        prefixIcon: Icon(Icons.email_sharp,size: 20,),
                        validator:(value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }

                          // Simple email format check
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email address';
                          }

                          return null; // If the email is valid
                        },
                                ),
                      SizedBox(
                        height: 30,
                      ),
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "* ",
                                    style:TextStyle(
                                        fontSize: 12,
                                        color: Colors.red
                                    ) ),
                                TextSpan(text: "We will send you a message to set or reset your new password ",
                                    style:TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey
                                    ) ),

                              ]
                          )
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Custombutton(
                        text: "Submit",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // final emailPass = email.text.trim();
                            // final success = await auth.requestPasswordReset(emailPass);
                            //
                            // // Display success or error message
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(
                            //       success
                            //           ? 'Password reset email sent! Please check your inbox.'
                            //           : 'Failed to send reset email. Please try again.',
                            //     ),
                            //     backgroundColor: success ? Colors.green : Colors.red,
                            //   ),
                            // );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}