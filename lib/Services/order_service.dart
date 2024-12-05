import 'package:ecommerce_app/model/order_model.dart';
import 'package:pocketbase/pocketbase.dart';

class OrderService {
  final PocketBase pb;

  OrderService(this.pb);

  Future<void> createOrder(
      String productId, String userEmail, String paymentMode, String paymentStatus) async {
    try {
      final body = <String, dynamic>{
        "productId": productId,
        "userEmail": userEmail,
        "paymentMode": paymentMode,
        "paymentStatus": paymentStatus,
      };

      final record = await pb.collection('orders').create(body: body);
      print("Order created successfully: ${record.toJson()}");
    } catch (e) {
      print("Failed to create order: $e");
      rethrow;
    }
  }

  Future<List<Order>> fetchOrders(String userEmail) async {
    try {
      print("Fetching orders for userEmail: $userEmail");
      final records = await pb.collection('orders').getFullList(
        filter: 'userEmail = "$userEmail"',
        expand: 'userEmail',
      );

      print("Fetched raw records: ${records.map((e) => e.data).toList()}");

      return records.map((record) {
        try {
          return Order.fromJson(record.data); // Map PocketBase response to Order model
        } catch (e) {
          print("Error parsing record: ${record.data}, error: $e");
          return null; // Skip invalid records
        }
      }).whereType<Order>().toList(); // Remove nulls
    } catch (e) {
      print("Error fetching orders for userEmail $userEmail: $e");
      return [];
    }
  }
}
