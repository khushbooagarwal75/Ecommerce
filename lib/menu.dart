import 'package:ecommerce_app/checkout.dart';
import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/navigationMenuPages/wishlist.dart';
import 'package:ecommerce_app/placeOrder.dart';
import 'package:ecommerce_app/navigationMenuPages/profile.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:ecommerce_app/side_drawer.dart';
import 'package:ecommerce_app/trendingProducts.dart'; // Import wishlist screen (replace Text widget)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  int _currentIndex =
      0; // Tracks the selected index of the bottom navigation bar
  String?
      userEmail; // Watch the user ID from Riverpod (using the userIdProvider)
  late SharedPreferences sp;
  final List<Widget> _pages = [
    Home(),
    Wishlist(),
    Text("Search"),
    Profile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Screens for each navigation item
    final List<Widget> _pages = [
      Home(),
      Wishlist(), // Replace the placeholder with the actual wishlist screen
      Text("Search"), // Placeholder, replace with search functionality
      Profile(), // Placeholder, replace with settings functionality
    ];

    return Scaffold(
      drawer: AppSideDrawer(userEmail: userEmail), // Add this line
      appBar: AppBar(
        title: Text("Cartify"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu)),
        ),
        actions: [
          // TextButton(
          //   onPressed: () async {
          //     if (userEmail == null) {
          //       Navigator.pushReplacement(context, MaterialPageRoute(
          //         builder: (context) {
          //           return Login();
          //         },
          //       ));
          //     } else {
          //       _showLogoutConfirmationDialog(context, _logout);
          //     }
          //   },
          //   child: userEmail == null
          //       ? const Text('No user is logged in.')
          //       : Text(userEmail!),
          // )S
        ],
      ),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex, // Highlight the current tab
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update the current index on tap
              });
            },
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            selectedFontSize: 16,
            unselectedFontSize: 16,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: Colors.black),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: "You",
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(
      BuildContext context, VoidCallback onConfirmLogout) {
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
                onConfirmLogout(); // Call the logout function
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }
}
