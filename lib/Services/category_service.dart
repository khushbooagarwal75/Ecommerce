import 'package:ecommerce_app/model/category_model.dart';
import 'package:pocketbase/pocketbase.dart';

class CategoryService {
  final PocketBase client;


  CategoryService(this.client);


  Future<List<Category>> fetchCategories() async {
    try {
      final result = await client.collection('categories').getList();
      return result.items.map((item) => Category.fromJson(item.toJson())).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
