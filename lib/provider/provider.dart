import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/Services/category_service.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/product_model.dart';

// Determine the appropriate base URL
String getBaseUrl() {
  return 'http://192.168.38.32:8090';
}

// Initialize PocketBase client
final pocketBaseClientProvider = Provider((ref) => PocketBase(getBaseUrl()));

// Authentication Provider
final pocketBaseAuthProvider = Provider((ref) {
  final client = ref.read(pocketBaseClientProvider);
  return PocketBaseAuthService(client); // Ensure this class expects a `PocketBase` instance.
});

// Registration Provider
final registerUserProvider = FutureProvider.family<void, Map<String, String>>((ref, credentials) async {
  final authService = ref.read(pocketBaseAuthProvider);
  await authService.registerUser(credentials['email']!, credentials['password']!);
});

// Login Provider
final loginUserProvider = FutureProvider.family<void, Map<String, String>>((ref, credentials) async {
  final authService = ref.read(pocketBaseAuthProvider);
  await authService.loginUser(credentials['email']!, credentials['password']!);
});

// Products Provider
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final client = ref.read(pocketBaseClientProvider);
  final service = ProductService(client);
  return await service.fetchProducts();
});

// Category Provider
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final client = ref.read(pocketBaseClientProvider);
  final service = CategoryService(client);
  return await service.fetchCategories();
});

final productServiceProvider = Provider<ProductService>((ref) {
  final client = ref.read(pocketBaseClientProvider); // Get the PocketBase client
  return ProductService(client); // Create and return the ProductService instance
});
