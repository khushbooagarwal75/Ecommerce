import 'package:ecommerce_app/components/customButton.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),),
                  Text("AMOUNT",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),),
                ],
              ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),),
                Text("AMOUNT",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),),
              ],
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                  style: TextStyle(

                      fontSize: 16
                  ),),
                Text("AMOUNT",
                  style: TextStyle(

                      fontSize: 16
                  ),),
              ],
            ),
            SizedBox(height: 20,),

            Divider(
              height: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Payment",
              style: TextStyle(
                  fontSize: 16
              ),),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.grey.shade200,

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Cash on delivery",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              )
            ),
            SizedBox(
              height: 20,
            ),
            Custombutton(
                text: "Continue",
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    barrierColor: Colors.black54,
                    pageBuilder: (context, animation1, animation2) {
                      return Center(
                        child: Material(
                          color: Colors.transparent, // Transparent background
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white, // Dialog box color
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
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
                        ),);
                    },);
                }
            ),
          ],
        ),
      ),
    );
  }
}
