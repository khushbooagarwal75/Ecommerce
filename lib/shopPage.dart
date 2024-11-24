import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/checkout.dart';
import 'package:ecommerce_app/placeOrder.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Shoppage extends StatelessWidget {
  final String imageUrl; // URL for product image
  final String name; // Product name
  final String size; // Product size
  final String details; // Product details
  final double price;
  const Shoppage({super.key, required this.imageUrl, required this.name, required this.size, required this.details, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [

          IconButton(
              onPressed: () {

              }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl),
          Center(
            child: DotsIndicator(
                dotsCount: 4,
              decorator: DotsDecorator(
                activeColor:Colors.red
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Size: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
            Card(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(size,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize:10
                  ),),
              ),

              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
              ),
            ),
              ],
            ),
          ),

          Text(details),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),

                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Checkout();
                      },));
                  },
                  child: Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(
                                Icons.shopping_cart,
                              )),
                          Text("Go to cart",
                              style:TextStyle(
                                  color: Colors.white,
                                  fontSize: 22
                              )),
                        ],
                      ),

                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),

                    ),
                  ),
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Placeorder(
                              name: name,
                              price: price,
                              imageUrl: imageUrl,
                              description: details,

                            );
                          },));
                  },
                  child: Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.money,
                              )),
                          Text("Buy Now",
                              style:TextStyle(
                                  color: Colors.white,
                                  fontSize: 22
                              )),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

