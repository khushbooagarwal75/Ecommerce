import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/trendingProducts.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              "All Featured",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red.shade300),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/images/cartify.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("data")
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Stack(
              children: [
                Image.asset(
                  "assets/images/Rectangle48.png",
                ),
                Positioned(
                    top: 30,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "50-40% OFF",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Now in [product]",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "All colours",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 100, // Adjust width
                          height: 30, // Adjust height
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8), // Reduce internal padding
                              side: BorderSide(color: Colors.white, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(0, 0), // Allows reducing button size
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Shop Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.black,
                                  size: 16, // Adjust icon size
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DotsIndicator(
                dotsCount: 3,
                decorator: DotsDecorator(
                  activeColor: Colors.pinkAccent.shade100,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deal of the Day",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "20h 55m 2s remaining",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100, // Adjust width
                      height: 30, // Adjust height
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8), // Reduce internal padding
                          side: BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(0, 0), // Allows reducing button size
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                              size: 16, // Adjust icon size
                            ),
                          ],
                        ),
                      ),
                    )

                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
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
                      Text("Products \ndetails \nprice "),
                      Text("price 20%off"),
                      Text("Rating")
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/offers.png"),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "Special Offers",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We make sure you get the \noffer you need at best prices",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4)
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/WhiteHeels.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text("Flat and Heels"),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Stand a chance to get rewarded"),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Visit now  ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.pink.shade400.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trending Products",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Last Date 19/12/24",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100, // Adjust width
                      height: 30, // Adjust height
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8), // Reduce internal padding
                          side: BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(0, 0), // Allows reducing button size
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Trendingproducts();
                          },));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                              size: 16, // Adjust icon size
                            ),
                          ],
                        ),
                      ),
                    )

                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
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
            SizedBox(
              height: 10,
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/salesBoard.png",
                  ),
                  Text("New Arrivals",
                    style: TextStyle(
                    fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Summer' 25 Collections",
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              // minimumSize: Size(0, 0), // Allow button to shrink below default size
                              // elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "View all  ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sponsored",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Image.asset("assets/images/percent50.jpg"),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upto 50% Off",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            
                          }, 
                          icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }
}
