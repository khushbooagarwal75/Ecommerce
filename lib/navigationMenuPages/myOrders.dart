import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/order_model.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/shopPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/provider.dart';

class Myorders extends ConsumerStatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  _MyordersState createState() => _MyordersState();
}

class _MyordersState extends ConsumerState<Myorders> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    loadUserEmail();
  }

  Future<void> loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userId');
    });
  }

  Widget _buildEmptyState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No Orders!!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "You can see Buyed Items here!",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    ),
  );

  Widget _buildErrorState(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
        const SizedBox(height: 16),
        Text(
          "Oops! Something went wrong",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          error,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _buildOrderItem(Order order, Product product) => Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: ListTile(
      leading: Image.network(
        product.getImageUrl(getBaseUrl()),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 80,
          height: 80,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 40),
        ),
      ),
      title: Text(
        product.product_name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.product_desc,
              style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            'Rs ${product.product_price}',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Payment Mode: ${order.paymentMode}'),
          Text('Payment Status: ${order.paymentStatus}'),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Shoppage(id: product.id, productService: ref.read(productServiceProvider)),
          ),
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (userEmail == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: _buildEmptyState(),
      );
    }

    final orderAsyncValue = ref.watch(orderProvider(userEmail!));

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(orderProvider(userEmail!)),
        child: orderAsyncValue.when(
          data: (orderItems) {
            if (orderItems.isEmpty) return _buildEmptyState();
            return ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                final order = orderItems[index];
                return FutureBuilder<Product>(
                  future: ref.read(productServiceProvider).fetchProductById(order.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 100,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError) {
                      return _buildErrorState(snapshot.error.toString());
                    }
                    if (!snapshot.hasData) return const SizedBox.shrink();

                    final product = snapshot.data!;
                    return _buildOrderItem(order, product);
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _buildErrorState(error.toString()),
        ),
      ),
    );
  }
}
