import 'package:ecommerce_app/model/category_model.dart';
import 'package:pocketbase/pocketbase.dart';

class CategoryService {
  final PocketBase client;

  // Constructor to initialize with the PocketBase client
  CategoryService(this.client);

  // Fetch categories using PocketBase API
  Future<List<Category>> fetchCategories() async {
    try {
      // Fetch the list of categories from the 'categories' collection
      final result = await client.collection('categories').getList();

      // Map the response items to Category model
      return result.items.map((item) => Category.fromJson(item.toJson())).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
