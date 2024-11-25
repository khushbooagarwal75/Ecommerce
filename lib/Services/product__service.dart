import 'package:ecommerce_app/model/product_model.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductService {
  final PocketBase client;

  // Constructor accepting the PocketBase client
  ProductService(this.client);

  // Fetch products using the PocketBase API
  Future<List<Product>> fetchProducts() async {
    try {
      // Fetch the list of products from the 'products' collection
      final result = await client.collection('products').getList();

      // Map the response items to Product model
      return result.items.map((item) => Product.fromJson(item.toJson())).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
  Future<Product> fetchProductById(String id) async {
    try {
      final record = await client.collection('products').getOne(id);
      return Product.fromJson(record.toJson());
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
