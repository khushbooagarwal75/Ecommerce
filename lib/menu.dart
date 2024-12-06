import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/navigationMenuPages/myOrders.dart';
import 'package:ecommerce_app/navigationMenuPages/wishlist.dart';
import 'package:ecommerce_app/navigationMenuPages/profile.dart';
import 'package:ecommerce_app/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  int _currentIndex = 0;
  String? userEmail;
  late SharedPreferences sp;
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
      Wishlist(),
      Myorders(),
      Profile(),
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
        actions: [],
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
}
