import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/forgotPassword.dart';
import 'package:ecommerce_app/menu.dart';
import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? currentUserId;
  final ImagePicker profilePic = ImagePicker();
  XFile? _image;
  Map<String, dynamic> userRecord = {};

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

    if (currentUserId != null) {
      try {
        final fetchedUserRecord = await authService.fetchUserDetails(currentUserId!); // This is where you get the user's data
        if (fetchedUserRecord != null) {
          setState(() {
            userRecord = fetchedUserRecord; // Store the fetched user record
            String avatarUrl = userRecord["avatar"] ?? '';  // Assuming "avatar" field contains the image URL
            _image = avatarUrl.isNotEmpty ? XFile(avatarUrl) : null;

            pincode.text = userRecord["pincode"]?.toString() ?? "";
            address.text = userRecord["address"] ?? "";
            cityController.text = userRecord["city"] ?? "";
            country.text = userRecord["country"] ?? "";
            accountNo.text = userRecord["accountNo"] ?? "";
            accountHolderName.text = userRecord["accountHolderName"] ?? "";
            ifsc.text = userRecord["ifscCode"] ?? "";
            dropdownValue = userRecord["state"] ?? city.first; // Default to first city if no state
          });
        }
      } catch (e) {
        // Handle any errors while fetching user data
        print("Error fetching user data: $e");
      }
    }

    if (currentUserId != null) {
      try {
        final userRecord = await authService.fetchUserDetails(currentUserId!); // This is where you get the user's data
        if (userRecord != null) {
          setState(() {
            // Populate the fields with the saved data

            String avatarUrl = userRecord["avatar"] ?? '';  // Assuming "avatar" field contains the image URL
            _image = avatarUrl.isNotEmpty ? XFile(avatarUrl) : null;

            pincode.text = userRecord["pincode"]?.toString() ?? "";
            address.text = userRecord["address"] ?? "";
            cityController.text = userRecord["city"] ?? "";
            country.text = userRecord["country"] ?? "";
            accountNo.text = userRecord["accountNo"].toString() ?? "";
            accountHolderName.text = userRecord["accountHolderName"] ?? "";
            ifsc.text = userRecord["ifscCode"].toString()  ?? "";
            dropdownValue = userRecord["state"] ?? city.first; // Default to first city if no state
          });
        }
      } catch (e) {
        // Handle any errors while fetching user data
        print("Error fetching user data: $e");
      }
    }
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
      final XFile? image =
      await profilePic.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: getImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _image != null
                                  ? FileImage(File(_image!.path)) // If _image is not null, use it
                                  : (_image == null && userRecord["avatar"] != null && userRecord["avatar"].isNotEmpty
                                  ? NetworkImage(userRecord["avatar"])  // Fetch from URL if available
                                  : AssetImage("assets/images/user_avatar.png"))
                              as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tap to change profile picture",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgotpassword(),
                          ));
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                // Business Address Section
                _buildSectionTitle("Business Address Details"),
                _buildTextField(
                  controller: pincode,
                  label: "Pincode",
                  hint: "Enter pincode",
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: address,
                  label: "Address",
                  hint: "Enter full address",
                ),
                _buildTextField(
                  controller: cityController,
                  label: "City",
                  hint: "Enter city name",
                ),
                _buildStateDropdown(),
                _buildTextField(
                  controller: country,
                  label: "Country",
                  hint: "Enter country name",
                ),

                // Bank Details Section
                _buildSectionTitle("Bank Account Details"),
                _buildTextField(
                  controller: accountNo,
                  label: "Bank Account Number",
                  hint: "Enter account number",
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: accountHolderName,
                  label: "Account Holder's Name",
                  hint: "Enter account holder name",
                ),
                _buildTextField(
                  controller: ifsc,
                  label: "IFSC Code",
                  hint: "Enter IFSC code",
                ),

                SizedBox(height: 20),

                // Save Button
                Custombutton(
                  text: "Save Changes",
                  onPressed: () async {
                    if (currentUserId != null) {
                      String? avatarUrl;
                      if (_image != null) {
                        avatarUrl = await uploadProfilePicture(_image!);
                      }

                      final data = {
                        if (avatarUrl != null) 'avatar': avatarUrl,
                        'pincode': pincode.text.isNotEmpty ? int.tryParse(pincode.text) : null,
                        'address': address.text.trim(),
                        'city': cityController.text.trim(),
                        'state': dropdownValue.trim(),
                        'country': country.text.trim(),
                        'accountNo': accountNo.text.trim(),
                        'accountHolderName': accountHolderName.text.trim(),
                        'ifscCode': ifsc.text.trim(),
                      };

                      data.removeWhere((key, value) => value == null);

                      try {
                        await authService.updateRecord(currentUserId!, data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User information updated!")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error updating user: ${e.toString()}")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User not logged in.")),
                      );
                    }
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateDropdown() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "State",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                style: TextStyle(color: Colors.black),
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: city.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }

  Future<String?> uploadProfilePicture(XFile image) async {
    try {
      final uri = Uri.parse('https://cartify-ecommerce.pockethost.io/api/files/users'); // Update with actual API
      final request = http.MultipartRequest('POST', uri);

      final file = File(image.path);
      final multipartFile = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(multipartFile);

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        return responseJson['url']; // Adjust key based on PocketBase API response
      } else {
        print('File upload failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

}
