import 'dart:convert';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:http/http.dart' as http;


class CategoryService {
  final String baseUrl;

  CategoryService(this.baseUrl);

  Future<List<Category>> fetchCategories() async {
  final url = Uri.parse('$baseUrl/api/collections/categories/records');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['items'];
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories: ${response.body}');
  }
}
}
