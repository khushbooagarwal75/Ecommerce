import 'package:ecommerce_app/Services/order_service.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/navigationMenuPages/myOrders.dart';
import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends ConsumerStatefulWidget {
  final String productId;
  final ProductService productService;
  Payment({super.key, required this.productId, required this.productService});

  @override
  ConsumerState<Payment> createState() => _PaymentState();
}

class _PaymentState extends ConsumerState<Payment> {
  late ValueNotifier<String?> selectedPaymentMethod;
  String? paymentMethod;
  String? paymentStatus;
  final OrderService orderService = OrderService(PocketBase(getBaseUrl()));

  String? userId;

  @override
  void initState() {
    super.initState();
    // Initialize ValueNotifier to track selected payment method
    selectedPaymentMethod = ValueNotifier<String?>(null);
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  void dispose() {
    selectedPaymentMethod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder<Product>(
        future: widget.productService.fetchProductById(widget.productId),
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
                // Order details
                _buildSummaryRow("Order", "AMOUNT"),
                SizedBox(height: 20),
                _buildSummaryRow("Shipping", "AMOUNT"),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Divider(height: 2),
                SizedBox(height: 20),
                Text("Payment",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                // Payment methods
                ValueListenableBuilder<String?>(
                  valueListenable: selectedPaymentMethod,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        _buildPaymentMethodCard(
                          "Cash on delivery",
                          value,
                          (method) {
                            selectedPaymentMethod.value = method;
                            paymentMethod = method;
                            paymentStatus = "Pending";
                          },
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethodCard(
                          "Credit Card",
                          value,
                          (method) {
                            selectedPaymentMethod.value = method;
                            paymentMethod = method;
                            paymentStatus = "Success";
                          },
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethodCard(
                          "Debit Card",
                          value,
                          (method) {
                            selectedPaymentMethod.value = method;
                            paymentMethod = method;
                            paymentStatus = "Success";
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),

                ValueListenableBuilder<String?>(
                  valueListenable: selectedPaymentMethod,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: value != null
                          ? () async {
                              if (userId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("User not logged in")),
                                );
                                return;
                              }
                              try {
                                print("Product ID: ${product.id}");
                                print("Payment Method: $paymentMethod");
                                print("Payment Status: $paymentStatus");

                                await orderService.createOrder(
                                  product.id,
                                  userId!,
                                  paymentMethod!,
                                  paymentStatus!,
                                );

                                _handlePayment(context);
                              } catch (e) {
                                print("Error during order creation: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            }
                          : null,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handlePayment(BuildContext context) async {
    // Show dialog
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black54,
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
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
                    "Order Successful",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Myorders(),
      ),
      (route) => route
          .isFirst,
    );
  }


  Widget _buildPaymentMethodCard(
    String methodName,
    String? selectedMethod,
    ValueChanged<String> onSelect,
  ) {
    final bool isSelected = selectedMethod == methodName;

    return GestureDetector(
      onTap: () {
        onSelect(methodName);
      },
      child: Card(
        shape: isSelected
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              )
            : null,
        color: Colors.grey.shade200,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                methodName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}
