import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Shoppage extends StatelessWidget {
  const Shoppage({super.key});

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
          Image.asset("assets/images/cartify.png",),
          Center(
            child: DotsIndicator(
                dotsCount: 4,
              decorator: DotsDecorator(
                activeColor:Colors.red
              ),

            ),
          ),
          Text("Size: 7UK"),
          Card(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("6UK",
              style: TextStyle(
                color: Colors.red,
                fontSize:10
              ),),
            ),

            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
            ),
          ),
          Text("Product Details"),
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
