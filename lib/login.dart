import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/components/socialNetworks.dart';
import 'package:ecommerce_app/forgotPassword.dart';
import 'package:ecommerce_app/getStarted.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:ecommerce_app/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State provider to manage password visibility
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watching password visibility state
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Pagetitle(
                  text1: "Welcome",
                  text2: "Back!",
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }

                          // Simple email format check
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email address';
                          }

                          return null; // If the email is valid
                        },
                        controller: emailController,
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.person, size: 25),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: passwordController,
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
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  Forgotpassword(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Custombutton(
                        text: "Login",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final authService = ref.read(pocketBaseAuthProvider);
                            try {
                              // Attempt login
                              await authService.loginUser(
                                emailController.text,
                                passwordController.text,
                              );

                              // Debugging to check if the login was successful
                              final loggedInUserId = authService.getLoggedInUserId();

                              // If no user ID, handle the error
                              if (loggedInUserId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login failed. No user ID found.")),
                                );
                                return;
                              }

                              // Storing user data in SharedPreferences
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString("userEmail", emailController.text);
                              await prefs.setString("userId", loggedInUserId.toString());
                              await prefs.setBool("isLoggedIn",true);

                              // Navigating to the next screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Getstarted(),
                                ),
                              );
                            } catch (e) {
                              print('Login Error: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Failed! Email or password is incorrect")),
                              );
                            }
                          }
                        },
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 100),
                Socialnetworks(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Signup(),
                      ),
                    );
                  },
                  text1: "Create An Account ",
                  text2: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
