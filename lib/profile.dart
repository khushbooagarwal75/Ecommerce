import 'package:ecommerce_app/components/customButton.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email=TextEditingController();
    List<String> city=["Vapi","Surat","Ahemdabad"];
    int selectedIndex=0;
    String dropdownValue = city.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  child: Image.asset("assets/images/google.png"),
                ),
              ),
              SizedBox(height: 10,),
              Text("Personal Details",
                style: TextStyle(
                fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),

              Text("Email Address",
                style: TextStyle(
                fontSize: 12,

              ),),
              SizedBox(height: 10,),
              TextField(
                  controller: email,
                  decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(
                  fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 1,),
                  borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1,),
                  borderRadius: BorderRadius.circular(10)
                  ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  ),
              SizedBox(height: 10,),

              Text("Password",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                obscuringCharacter: "*",
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left:260.0),
                child: Text("Change Password",
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontSize: 10,
                    decorationColor: Colors.red
                ),),
              ),
              SizedBox(height: 20,),

              Divider(
                color: Colors.grey,
                height: 5,

              ),


              SizedBox(height: 10,),
              Text("Business Address Details",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 10,),

              Text("Pincode",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Pincode",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10,),

              Text("Address",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 10,),

              Text("City",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "City",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),

              Text("State",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),

              Text("Country",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Country",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),

              Divider(
                color: Colors.grey,
                height: 5,

              ),

              SizedBox(height: 10,),
              Text("Bank Account Details",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 10,),

              Text("Bank Account Number",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Pincode",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10,),

              Text("Account Holder's Name",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 10,),

              Text("IFSC Code",
                style: TextStyle(
                  fontSize: 12,

                ),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "City",
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1,),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),

              Custombutton(
                  text: "Save",
                  onPressed: () {

                  },)
            ],
          ),
        ),
      ),
    );
  }
}
