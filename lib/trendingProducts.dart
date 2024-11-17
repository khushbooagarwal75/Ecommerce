import 'package:flutter/material.dart';

class Trendingproducts extends StatefulWidget {
  const Trendingproducts({super.key});

  @override
  State<Trendingproducts> createState() => _TrendingproductsState();
}

class _TrendingproductsState extends State<Trendingproducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.2),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white70,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.mic_none,
                              color: Colors.grey,
                            ),
                            hintText: "Search any Product..",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black12)))),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "52900+  Items",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/cartify.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text("Products \nprice "),
                                  Text("price 20%off"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/cartify.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text("Products \nprice "),
                                  Text("price 20%off"),
                                ],
                              ),
                            ),
                          ],
                        ),
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
