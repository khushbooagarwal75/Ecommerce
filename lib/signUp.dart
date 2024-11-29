import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/components/socialNetworks.dart';
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  TextEditingController reg_email = TextEditingController();
  TextEditingController reg_password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  void dispose() {
    reg_email.dispose();
    reg_password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watching password visibility state for both fields
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isConfirmPasswordVisible = ref.watch(confirmPasswordVisibilityProvider); // Consider separate state for confirmPassword if needed

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Pagetitle(
                    text1: "Create an ",
                    text2: "account"),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        type: TextInputType.emailAddress,
                        controller: reg_email,
                        hintText: "Username or Email",
                        prefixIcon: Icon(Icons.person,size: 25,),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }

                        // Simple email format check
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Enter a valid email address';
                        }

                        return null; // If the email is valid
                      },),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: reg_password,
                        hintText: "Password",
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        isPasswordVisible: isPasswordVisible,
                        prefixIcon: const Icon(Icons.lock),
                        validator: (value) {
                          if( value!.isNotEmpty) {
                            if( value!.length<=10 && value!.length>=16) {
                              return 'Password should be between 10 to 16 characters only';
                            }
                          }
                          else{
                            return 'Please enter your password again';
                          }
                        },
                        onTogglePasswordVisibility: () {
                          ref
                              .read(passwordVisibilityProvider.notifier)
                              .state = !isPasswordVisible;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: confirmPassword,
                        hintText: "Password",
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        isPasswordVisible: isConfirmPasswordVisible,
                        prefixIcon: const Icon(Icons.lock),
                        validator: (value) {
                          if( value!.isNotEmpty) {
                            if(value!.length<=10 && value!.length>=16) {
                              return 'Password should be between 10 to 16 characters only';
                            }
                          }
                          else{
                            return 'Please enter your password again';
                          }
                        },
                        onTogglePasswordVisibility: () {
                          ref
                              .read(confirmPasswordVisibilityProvider.notifier)
                              .state = !isConfirmPasswordVisible;
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "By Clicking the ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,

                                  ),),
                                TextSpan(text: "Register ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,

                                  ),),
                                TextSpan(text: "button, you agree \nto the terms & conditions",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,

                                  ),),
                              ]
                          )),
                      SizedBox(
                        height: 40,
                      ),

                      Custombutton(
                        text: "Create Account",
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            if (reg_password.toString() ==
                                confirmPassword.toString()) {
                              final authService = ref.read(
                                  pocketBaseAuthProvider);
                              try {
                                final message = await authService.registerUser(
                                  reg_email.text,
                                  reg_password.text,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("User Registered")));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "User Registeration Failed!!")));
                              }
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      "Password and confirm Password should be same")));
                            }
                          }

                        },),
                    ],
                  ),
                ),

                SizedBox(
                  height: 80,
                ),
                Socialnetworks(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },));
                    },
                    text1: "I Already Have an Account ",
                    text2: "Login")



              ],
            ),
          ),
        ),
      ),

    );
  }
}
