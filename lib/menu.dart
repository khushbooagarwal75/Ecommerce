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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Are you sure you want to log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear(); // Clear all preferences
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (Route<dynamic> route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Failed to log out. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
