import 'dart:convert';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:http/http.dart' as http;


class PocketBaseService {
  final String baseUrl;

  PocketBaseService(this.baseUrl);

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/api/collections/products/records');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['items'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }
}

