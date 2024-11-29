import 'package:ecommerce_app/Services/payment_notifier.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/navigationMenuPages/home.dart';
import 'package:ecommerce_app/menu.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Payment extends ConsumerWidget {
  final String id;
  final ProductService productService;
  const Payment({super.key, required this.id, required this.productService});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "AMOUNT",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "AMOUNT",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        product.product_price.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Cash on delivery",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Cash on delivery",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Cash on delivery",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Custombutton(
                      text: "Continue",
                      onPressed: () async{
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierLabel: '',
                          barrierColor: Colors.black54,
                          pageBuilder: (context, animation1, animation2) {
                            return Center(
                              child: Material(
                                color: Colors
                                    .transparent, // Transparent background
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Dialog box color
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 80,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Payment Successful",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return Menu();
                            },));
                      }),
                ],
              ),
            );
          }),
    );
  }
}
