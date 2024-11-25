import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/checkout.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/placeOrder.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Shoppage extends StatelessWidget {
  final String id;
  final ProductService productService;

  const Shoppage({super.key, required this.id, required this.productService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: FutureBuilder<Product>(
        future: productService.fetchProductById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Product not found.'));
          }

          final product = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.network(product.getImageUrl(getBaseUrl() as String),)),
              SizedBox(height: 10,),
              Center(
                child: DotsIndicator(
                  dotsCount: 4,
                  decorator: DotsDecorator(activeColor: Colors.red),
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
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.id,
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(product.product_desc),
              SizedBox(height: 10),
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Checkout(
                              id: product.id,
                              productService: productService,
                            );
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.shopping_cart)),
                          Text(
                            "Go to cart",
                            style: TextStyle(color: Colors.white, fontSize: 22),
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Placeorder(
                            productService: productService,
                              id: product.id,
                            );
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(Icons.money)),
                          Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

