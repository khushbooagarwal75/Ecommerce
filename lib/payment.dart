import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/components/customButton.dart';
import 'package:ecommerce_app/menu.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Payment extends ConsumerWidget {
  final String id;
  final ProductService productService;

  const Payment({super.key, required this.id, required this.productService});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using ValueNotifier to track selected payment method
    final ValueNotifier<String?> selectedPaymentMethod = ValueNotifier<String?>(null);

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
                // Order details
                _buildSummaryRow("Order", "AMOUNT"),
                SizedBox(height: 20),
                _buildSummaryRow("Shipping", "AMOUNT"),
                SizedBox(height: 20),
                _buildSummaryRow("Total", product.product_price.toString()),
                SizedBox(height: 20),
                Divider(height: 2),
                SizedBox(height: 20),
                Text("Payment", style: TextStyle(fontSize: 16)),
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
                              (method) => selectedPaymentMethod.value = method,
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethodCard(
                          "Credit Card",
                          value,
                              (method) => selectedPaymentMethod.value = method,
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethodCard(
                          "Debit Card",
                          value,
                              (method) => selectedPaymentMethod.value = method,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),

                // Continue button
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
                      onPressed: value != null // Check if a payment method is selected
                          ? () async {
                        _handlePayment(context);
                      }
                          : null, // Disable the button if no method is selected
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
                    "Payment Successful",
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

    // Simulate a delay for the dialog to show
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to the next screen after the delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Menu(); // Navigate to the next page
        },
      ),
    );
  }



  // Helper method to build payment method card
  // Helper method to build payment method card
  Widget _buildPaymentMethodCard(
      String methodName,
      String? selectedMethod,
      ValueChanged<String> onSelect,
      ) {
    final bool isSelected = selectedMethod == methodName;

    return GestureDetector(
      onTap: () => onSelect(methodName), // This updates the selected method
      child: Card(
        color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
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

  // Helper method to build summary row
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
