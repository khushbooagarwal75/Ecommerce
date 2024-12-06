import 'package:ecommerce_app/model/product_model.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductService {
  final PocketBase client;

  ProductService(this.client);

  Future<List<Product>> fetchProducts() async {
    try {
      final result = await client.collection('products').getList();

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
  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      final result = await client.collection('products').getList(
        page: 1,
        perPage: 50,
        filter: 'category_id = "$categoryId"',
      );

      if (result.items.isEmpty) {
        print('No products found for category: $categoryId');
      }

      return result.items.map((item) => Product.fromJson(item.toJson())).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      throw Exception('Failed to load products by category: $e');
    }
  }
}
