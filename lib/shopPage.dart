import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/checkout.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/model/wishlist_model.dart';
import 'package:ecommerce_app/placeOrder.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shoppage extends ConsumerStatefulWidget {
  final String id;
  final ProductService productService;

  const Shoppage({
    super.key,
    required this.id,
    required this.productService,
  });

  @override
  ConsumerState<Shoppage> createState() => _ShoppageState();
}

class _ShoppageState extends ConsumerState<Shoppage> {
  bool isWishlisted = false;
  String? currentUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use ref.read() to get the userId once
    loadUserData();
  }
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });
  }
  @override
  Widget build(BuildContext context) {
    final wishlistService = ref.read(wishlistServiceProvider);

    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final wishlistFuture = ref.watch(wishlistProvider(currentUserId!));

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

                  final wishlistItem = WishlistItem(userId: currentUserId!, productId: widget.id);

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
                        Navigator.pop(context);
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
                        if(currentUserId!=null){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Checkout(
                                id: product.id,
                                productService: widget.productService,
                              );
                            },
                          ));
                        }
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