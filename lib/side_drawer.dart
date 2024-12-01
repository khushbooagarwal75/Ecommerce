import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/navigationMenuPages/profile.dart';
import 'package:ecommerce_app/placeOrder.dart';

class AppSideDrawer extends StatelessWidget {
  final String? userEmail;

  const AppSideDrawer({Key? key, this.userEmail}) : super(key: key);

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("isLoggedIn", false);
                Navigator.of(context).pop(); // Close the dialog

                // Navigate to login screen
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 222, 217, 217),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  userEmail ?? 'Guest User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Wishlisted Product'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Rate Cartify'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text('Legal and policies'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('FAQS'),
            onTap: () {
              // Navigator.pop(context); // Close the drawer
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('Help Center'),
            onTap: () {
              //   Navigator.pop(context); // Close the drawer
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),

          // ListTile(
          //   leading: Icon(Icons.shopping_cart),
          //   title: Text('Orders'),
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => )
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
