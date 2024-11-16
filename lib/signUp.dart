import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/components/pageTitle.dart';
import 'package:ecommerce_app/components/socialNetworks.dart';
import 'package:ecommerce_app/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  TextEditingController reg_email=TextEditingController();
  TextEditingController reg_password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
   Signup({super.key});

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
                    text1: "Create an ",
                    text2: "account"),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  type: TextInputType.emailAddress,

                  controller: reg_email,
                  hintText: "Username or Email",
                  prefixIcon: Icon(Icons.person,size: 25,),),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(

                  controller: reg_password,
                  hintText: "Password",
                  type: TextInputType.visiblePassword,
                  isPassword: true, prefixIcon: Icon(Icons.lock,size: 20,),),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(

                  controller: reg_password,
                  hintText: "ConfirmPassword",
                  type: TextInputType.visiblePassword,
                  isPassword: true, prefixIcon: Icon(Icons.lock,size: 20,),),
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
                    onPressed: () {

                    },),
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
