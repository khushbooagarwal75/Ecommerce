import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/model/wishlist_model.dart';
import 'package:ecommerce_app/payment.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Placeorder extends ConsumerStatefulWidget {
  final String id;
  final ProductService productService;

  const Placeorder({
    super.key,
    required this.id,
    required this.productService,
  });

  @override
  ConsumerState<Placeorder> createState() => _PlaceorderState();
}

class _PlaceorderState extends ConsumerState<Placeorder> {
  bool isWishlisted = false;
  String? userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use ref.read() to get the userId once
    loadUserData();
  }
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }
  @override
  Widget build(BuildContext context) {
    final wishlistService = ref.read(wishlistServiceProvider);

    if (userId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final wishlistFuture = ref.watch(wishlistProvider(userId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Bag"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          wishlistFuture.when(
            data: (wishlistItems) {
              isWishlisted = wishlistItems.any((item) => item.productId == widget.id);

              return IconButton(
                onPressed: () async {
                  if (isWishlisted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Item is already in your wishlist."),
                      ),
                    );
                    return;
                  }

                  final wishlistItem = WishlistItem(userId: userId!, productId: widget.id);

                  try {
                    await wishlistService.addToWishlist(wishlistItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Item added to wishlist!"),
                      ),
                    );
                    setState(() {
                      isWishlisted = true;
                    });
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
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => const Icon(Icons.error, color: Colors.red),
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: widget.productService.fetchProductById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Product not found.'));
          }

          final product = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product details UI
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
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.product_desc,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "Delivery by  ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Delivery by",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Other details
              // Payment and buttons
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
              BottomSheet(
                onClosing: () {},
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(product.product_price.toString()),
                            const SizedBox(height: 2),
                            const Text(
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
                        const Spacer(),
                        Custombutton(
                          text: "Proceed to Payment",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Payment(
                                    id: product.id,
                                    productService: widget.productService,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

            ],
          );
        },
      ),
    );
  }
}
