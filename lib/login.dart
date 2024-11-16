import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/components/socialNetworks.dart';
import 'package:ecommerce_app/forgotPassword.dart';
import 'package:ecommerce_app/getStarted.dart';
import 'package:ecommerce_app/signUp.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Pagetitle(
                    text1: "Welcome",
                    text2: "Back!"),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  type: TextInputType.emailAddress,
          
                    controller: email,
                    hintText: "Username or Email", 
                  prefixIcon: Icon(Icons.person,size: 25,),),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  
                    controller: password,
                    hintText: "Password",
                    type: TextInputType.visiblePassword,
                isPassword: true, prefixIcon: Icon(Icons.lock,size: 20,),),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:0,left:220, top:0,right: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context) {
                          return Forgotpassword();
                        },));
                    },
                    child: Text("Forgot Password?",
                      style: TextStyle(
                       color: Colors.red,
                       fontSize: 12,

                      )),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Custombutton(
                    text: "Login",
                    onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                              return Getstarted();
                            },));
                    },
                ),
                SizedBox(
                  height: 100,
                ),
                Socialnetworks(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context) {
                          return Signup();
                        },));
                    },
                    text1: "Create An Account ",
                    text2: "Sign Up")
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
