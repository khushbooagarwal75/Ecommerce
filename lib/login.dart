import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/components/customTextField.dart';
import 'package:ecommerce_app/forgotPassword.dart';
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
                Text("Welcome \nBack!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),),
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
                  padding: const EdgeInsets.only(bottom:0,left:240, top:0,right: 5),
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
                       fontSize: 10,

                      )),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Custombutton(
                    text: "Login",
                    onPressed: () {

                    },
                ),
                SizedBox(
                  height: 100,
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
                              return Signup();
                            },));
                      },
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "Create An Account ",
                                    style:TextStyle(
                                        fontSize: 12,
                                        color: Colors.black
                                    ) ),
                                TextSpan(text: "Sign Up",
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
