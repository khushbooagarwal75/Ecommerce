import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class Forgotpassword extends StatelessWidget {
  TextEditingController email = TextEditingController();
  PocketBaseAuthService auth = PocketBaseAuthService(PocketBase(getBaseUrl()));
  final _formKey = GlobalKey<FormState>();

  Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This will navigate back
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Pagetitle(text1: "Forgot ", text2: "password?"),
                const SizedBox(
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
                        prefixIcon: Icon(
                          Icons.email_sharp,
                          size: 20,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "* ",
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                          TextSpan(
                            text:
                                "We will send you a message to set or reset your new password ",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Custombutton(
                        text: "Submit",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(child: CircularProgressIndicator());
                              },
                            );

                            final emailPass = email.text.trim();
                            final success = await auth.requestPasswordReset(emailPass);

                            Navigator.pop(context); // Close the loading dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Password reset email sent! Please check your inbox.'
                                      : 'Failed to send reset email. Please try again.',
                                 ),
                                backgroundColor: success ? Colors.green : Colors.red,
                              ),
                            );
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
