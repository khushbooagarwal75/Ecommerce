import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:ecommerce_app/shopPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends ConsumerStatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<Wishlist> {
  String? userId;
  ProductService? productService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use ref.read() to get the userId once
    productService = ref.read(productServiceProvider);
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
    if (userId == null) {
      return const Scaffold(
        body: Center(
            child: Text("You Don't have any item in Wishlist",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),)),
      );
    }

    // Watching the wishlistProvider with the retrieved userId
    final wishlistAsyncValue = ref.watch(wishlistProvider(userId!));

    return Scaffold(
      body: wishlistAsyncValue.when(
        data: (wishlistItems) {
          // Ensure that wishlistItems is not null and is not empty
          if (wishlistItems == null || wishlistItems.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          }
          return ListView.builder(
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final item = wishlistItems[index];
              return FutureBuilder<Product>(
                future: productService?.fetchProductById(item.productId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('Product not found.'));
                  }

                  final product = snapshot.data!;

                  return GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Shoppage(
                            id:item.productId,
                            productService: productService!);
                      },));
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width, // Ensure full width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150, // Constrained height for image
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                                child: Image.network(
                                  product.getImageUrl(getBaseUrl() as String),
                                  width: double.infinity,
                                  height: 150, // Ensure image has height
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.product_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product.product_desc,
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rs ${product.product_price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
