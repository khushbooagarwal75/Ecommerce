import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
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
                Text("Create an \naccount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("- OR Continue with -"),
                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red.shade300),
                            color: Colors.transparent,

                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/images/cartify.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red.shade300),
                            color: Colors.transparent,

                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/images/cartify.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red.shade300),
                            color: Colors.transparent,

                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/images/cartify.png"),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },));
                      },
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "I Already Have an Account ",
                                    style:TextStyle(
                                        fontSize: 12,
                                        color: Colors.black
                                    ) ),
                                TextSpan(text: "Login",
                                    style:TextStyle(
                                        fontSize: 12,
                                        color: Colors.red
                                    ) ),
                              ]
                          )
                      ),
                    )

                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
