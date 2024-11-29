import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/model/wishlist_model.dart';
import 'package:ecommerce_app/payment.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  class Placeorder extends ConsumerWidget {
  final String id;
  final ProductService productService;
  const Placeorder({super.key, required this.id, required this.productService});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final wishlistService = ref.read(wishlistServiceProvider);
    final activeUserId = ref.watch(userIdProvider);
    final wishlistFuture = ref.watch(wishlistProvider(activeUserId!));

    bool isWishlisted = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Bag"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          wishlistFuture.when(
            data: (wishlistItems) {
              final isWishlisted = wishlistItems.any((item) => item.productId == id);

              return IconButton(
                onPressed: () async {
                  if (isWishlisted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Item is already in your wishlist."),

                      ),
                    );
                    return;
                  }

                  final wishlistItem = WishlistItem(userId: activeUserId, productId: id);

                  try {
                    await wishlistService.addToWishlist(wishlistItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Item added to wishlist!"),

                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error adding to wishlist: $e"),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: isWishlisted ? Colors.red : Colors.grey,
                ),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, _) => Icon(Icons.error, color: Colors.red),
          ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        product.getImageUrl(getBaseUrl()),
                        width: 100,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                product.product_name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.product_desc,
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "Delivery by  ",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Delivery by",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.discount),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Apply Coupons",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.red,
                          decorationColor: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Order Payment Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Amounts",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "amount",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Convienence",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Know more",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decorationColor: Colors.red,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Apply Coupon",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "Delivery Fee",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Free",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "Order Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        product.product_price.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        "EMI Available",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),


              ],
            ),
          ),

          BottomSheet(onClosing: () {

          },
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(product.product_price.toString()),
                        SizedBox(height: 2,),
                        Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Custombutton(
                          text: "Proceed to Payment",
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Payment(
                                      id: product.id,
                                      productService: productService);
                                },));
                          },)
                      ],
                    ),
                  ],
                ),
              );
            },),
        ],
      );
    }
    ),
    );
  }
}