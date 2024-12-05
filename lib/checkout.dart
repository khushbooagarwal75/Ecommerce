import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/placeOrder.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends ConsumerStatefulWidget {
  final String id;
  final ProductService productService;


  const Checkout({
    super.key,
    required this.id,
    required this.productService,
  });

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  late TextEditingController addressController;
  late PocketBaseAuthService authService;
  String? userId;
  String? currentAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    authService = PocketBaseAuthService(PocketBase(getBaseUrl()));
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _showAddAddressDialog(BuildContext context, {String? userAddress}) {
      addressController.text = userAddress ?? '';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Address"),
            content: TextField(
              controller: addressController,
              decoration: InputDecoration(hintText: "Enter your address"),
              maxLines: 3,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  String newAddress = addressController.text.trim();
                  if (newAddress.isNotEmpty) {
                    authService.updateRecord(userId!, {"address": newAddress}).then((_) {
                      Navigator.pop(context);
                      setState(() {
                        currentAddress = newAddress;  // Update the address in the UI
                      });
                    });
                  }
                },
                child: Text("Save"),
              ),
            ],
          );
        },
      );
    }

    if (userId == null) {
      // Show loading indicator while `userId` is being fetched
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder<Product>(
        future: widget.productService.fetchProductById(widget.id),
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (productSnapshot.hasError) {
            return Center(child: Text('Error: ${productSnapshot.error}'));
          } else if (!productSnapshot.hasData || productSnapshot.data == null) {
            return const Center(child: Text('Product not found.'));
          }

          final product = productSnapshot.data!;
          return FutureBuilder<Map<String, dynamic>?>(
            future: authService.fetchUserDetails(userId!),
            builder: (context, addressSnapshot) {
              if (addressSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (addressSnapshot.hasError) {
                return Center(
                    child: Text('Error Fetching Address: ${addressSnapshot.error}'));
              }

              final address = addressSnapshot.data?['address'] ?? 'No address found';
              currentAddress = address; // Store the initial address

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 2),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 5),
                          Text(
                            "Delivery Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text("Address: $currentAddress"),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (currentAddress == null || currentAddress!.isEmpty) {
                                              _showAddAddressDialog(context);  // Show add address dialog
                                            } else {
                                              _showAddAddressDialog(context, userAddress: currentAddress);  // Edit existing address
                                            }
                                          },
                                          icon: const Icon(Icons.edit, size: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Shopping List",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
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
                                    width: 120,
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.product_name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          product.product_desc,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 1),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total Order (1):"),
                                  Text(product.product_price.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Custombutton(
                        text: "Continue",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Placeorder(
                                id: product.id,
                                productService: widget.productService);
                          },));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
