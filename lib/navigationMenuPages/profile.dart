import 'dart:io';

import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/forgotPassword.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;



class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  late TextEditingController pincode = TextEditingController();
  late TextEditingController address = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController country = TextEditingController();
  late TextEditingController accountNo = TextEditingController();
  late TextEditingController accountHolderName = TextEditingController();
  late TextEditingController ifsc = TextEditingController();
  late TextEditingController name = TextEditingController();

  late String dropdownValue = city.first;
  final List<String> city = ["Gujarat", "Maharashtra", "Uttar Pradesh"];
  final PocketBaseAuthService authService =
      PocketBaseAuthService(PocketBase(getBaseUrl()));
  String? currentUserId ;
  final ImagePicker profilePic= ImagePicker();
  XFile? _image;

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });
  }

  @override
  void dispose() {
    name.dispose();
    pincode.dispose();
    address.dispose();
    cityController.dispose();
    country.dispose();
    accountNo.dispose();
    accountHolderName.dispose();
    ifsc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      final XFile? image = await profilePic.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   centerTitle: true,
      //   leading: IconButton(
      //       onPressed: () {
      //
      //       },
      //       icon: Icon(Icons.arrow_back_ios)),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                       getImage();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        child:_image == null? Image.asset("assets/images/user_avatar.png"):
                        Image.file(File(_image!.path)),
                      ),
                    ),
                    // FloatingActionButton(
                    //
                    //   tooltip: 'Pick Image',
                    //   child: const Icon(Icons.add_a_photo),
                    // ),
                  ],
                ),
    ),


              SizedBox(
                height: 10,
              ),
              // Text(
              //   "Personal Details",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              //
              // Text("Email Address: ",
              //   style: TextStyle(
              //   fontSize: 12,
              //
              // ),),
              // SizedBox(height: 10,),
              // TextField(
              //   enabled: false,
              //     controller: email,
              //     decoration: InputDecoration(
              //     hintText: "",
              //     hintStyle: TextStyle(
              //     fontSize: 13,
              //     ),
              //     isDense: true,
              //     enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey,width: 1,),
              //     borderRadius: BorderRadius.circular(10)
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.black,width: 1,),
              //     borderRadius: BorderRadius.circular(10)
              //     ),
              //     ),
              //     keyboardType: TextInputType.emailAddress,
              //     ),
              Text(
                "Name",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(
                height: 10,
              ),

              // Text("Password",
              //   style: TextStyle(
              //     fontSize: 12,
              //
              //   ),),
              // SizedBox(height: 10,),
              // TextField(
              //   controller: email,
              //   decoration: InputDecoration(
              //     hintText: "Password",
              //     hintStyle: TextStyle(
              //       fontSize: 13,
              //     ),
              //     isDense: true,
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey,width: 1,),
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black,width: 1,),
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //   ),
              //   keyboardType: TextInputType.visiblePassword,
              //   obscureText: true,
              //   obscuringCharacter: "*",
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 260.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Forgotpassword();
                        },
                      ));
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          fontSize: 10,
                          decorationColor: Colors.red),
                    )),
              ),
              SizedBox(
                height: 20,
              ),

              Divider(
                color: Colors.grey,
                height: 5,
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "Business Address Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Pincode",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: pincode,
                decoration: InputDecoration(
                  hintText: "Pincode",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Address",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "City",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  hintText: "City",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "State",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: dropdownValue,
                  items: city.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Country",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: country,
                decoration: InputDecoration(
                  hintText: "Country",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),

              Divider(
                color: Colors.grey,
                height: 5,
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "Bank Account Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Bank Account Number",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountNo,
                decoration: InputDecoration(
                  hintText: "Bank Account Number",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Account Holder's Name",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountHolderName,
                decoration: InputDecoration(
                  hintText: "Account Holder's Name",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                "IFSC Code",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ifsc,
                decoration: InputDecoration(
                  hintText: "IFSC Code",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),

              // Custombutton(
              //   text: "Save",
              //   onPressed: () async {
              //     if (currentUserId != null) {
              //       try {
              //         // Prepare data without the 'email' field
              //         final data = {
              //           "pincode": pincode.text,
              //           "address": address.text,
              //           "city": cityController.text,
              //           "state":dropdownValue,
              //           "country":country.text,
              //           "accountNo":accountNo.text,
              //           "accountHolderName": accountHolderName.text,
              //           "ifscCode":ifsc.text
              //         };
              //         // Call the update function
              //         await authService.updateUser(currentUserId, data);
              //
              //         // Show success message
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text("User information updated!")),
              //         );
              //       } catch (e) {
              //         // Show error message
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text("Error updating user: $e")),
              //         );
              //       }
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text("User not logged in.")),
              //       );
              //     }
              //   },
              // ),
              Custombutton(
                text: "Save",
                onPressed: () async {
                  print(currentUserId);
                  if (currentUserId != null) {
                    // Collect only the fields you want to update
                    final data = {
                      "name":"kdjd",
                      "avatar":_image!.path,
                      "pincode":pincode.text.isNotEmpty
                          ? int.tryParse(pincode.text)
                          : null,
                      "address":address.text.trim(),
                      "city":cityController.text.trim(),
                      "state":dropdownValue.trim(),
                      "country":country.text.trim(),
                      "accountNo":accountNo.text.trim(),
                      "accountHolderName":accountHolderName.text.trim(),
                      "ifscCode":ifsc.text.trim(),
                    };
                    data.removeWhere(
                        (key, value) => value == null); // Remove null fields

                    try {
                      await authService.updateRecord(currentUserId!, data);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User information updated!")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Error updating user: ${e.toString()}")),
                      );
                    }
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User not logged in.")),
                    );
                  }
                },
              ),


              // Custombutton(
              //   text: "Save",
              //   onPressed: () async {
              //     print("Current User ID: $currentUserId");
              //
              //     if (currentUserId != null) {
              //       // Collect and validate the fields to update
              //       final data = {
              //         "pincode": pincode.text.isNotEmpty ? int.tryParse(pincode.text) : null,
              //         "address": address.text.trim(),
              //         "city": cityController.text.trim(),
              //         "state": dropdownValue.trim(),
              //         "country": country.text.trim(),
              //         "accountNo": accountNo.text.trim(),
              //         "accountHolderName": accountHolderName.text.trim(),
              //         "ifscCode": ifsc.text.trim(),
              //       };
              //
              //       // Remove fields with null values
              //       data.removeWhere((key, value) => value == null);
              //
              //       try {
              //         await authService.updateUser1(currentUserId!, data);
              //
              //         // Show success message
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text("User information updated!")),
              //         );
              //       } catch (e) {
              //         // Show error message
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text("Error updating user: ${e.toString()}")),
              //         );
              //       }
              //     } else {
              //       // User not logged in
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text("User not logged in.")),
              //       );
              //     }
              //   },
              // ),

            ],
          ),
        ),
      ),
    );
  }

}
