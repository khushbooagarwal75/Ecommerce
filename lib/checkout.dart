import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 2,

              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 5,),
                  Text("Delivery Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Address:"),
                              IconButton(onPressed: () {

                              }, icon: Icon(Icons.edit,size: 15,))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: IconButton(onPressed: () {

                      }, icon: Icon(Icons.add_circle_outline,size: 30,)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Shopping List",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
              SizedBox(
                height: 5,
              ),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                          Image.asset("assets/images/cartify.png", width: 120,),
                        Column(
                          children: [
                            Text("Women's Casual Wear",
                              style: TextStyle(
                                fontSize: 16
                              ),)
                          ],
                        )
                      ],
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Order (1) :"),
                        Text("data")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
