import 'package:pocketbase/pocketbase.dart';

class OrderService {
  final PocketBase pb;

  // Constructor accepting the PocketBase client
  OrderService(this.pb);

  Future<void> createOrder(String productId, String paymentMode, String paymentStatus) async {
    try {
      final body = <String, dynamic>{
        "productId": productId,
        "paymentMode": paymentMode,
        "paymentStatus": paymentStatus
      };

      final record = await pb.collection('orders').create(body: body);
      print("Order created successfully: $record");
    } catch (e) {
      print("Failed to create order: $e");
      rethrow;
    }
  }
}
