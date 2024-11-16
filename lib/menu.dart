import 'package:ecommerce_app/home.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _currentIndex = 0; // Tracks the selected index of the bottom navigation bar

  // Screens for each navigation item
  final List<Widget> _pages = [
    Home(),
    Center(child: Text("Wishlist", style: TextStyle(fontSize: 24))),
  Center(child: Text("Search Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Setting Page", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cartify"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/images/cartify.png"),
          )
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
                icon: Icon(Icons.home,color: Colors.black,),
                label: "Home",

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,color: Colors.black,),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.black,),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.black,),
                label: "Setting",
              ),


            ],
          ),
          Positioned(
            top: -28, // Adjusts the button position relative to the bar
            left: MediaQuery.of(context).size.width / 2 - 28, // Centers the button
            child: FloatingActionButton(
              onPressed: () {
                print("Cart Button Pressed");
              },
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],

      ),
    );
  }
}
