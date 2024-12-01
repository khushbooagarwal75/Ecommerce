import 'dart:io';
import 'package:ecommerce_app/Services/wishlist_service.dart';
import 'package:ecommerce_app/model/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/Services/category_service.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/product_model.dart';

// Determine the appropriate base URL
String getBaseUrl() {
  return 'http://192.168.27.32:8090';
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

final wishlistServiceProvider = Provider<WishlistService>((ref) {
  final client = ref.read(pocketBaseClientProvider);
  return WishlistService(client); // Corrected to return WishlistService
});

// Wishlist Items Provider
final wishlistProvider = FutureProvider.family<List<WishlistItem>, String>((ref, userId) async {
  final service = ref.read(wishlistServiceProvider);
  return await service.getWishlist(userId);
});

final userIdProvider = StateProvider<String?>((ref) {
  final authService = ref.read(pocketBaseAuthProvider);
  return authService.getLoggedInUserId(); // Initialize with the current user ID, if any
});

final productProviderByCategory = FutureProvider.family<List<Product>, String>((ref, categoryId) async {
  final productService = ref.read(productServiceProvider); // Fetch the ProductService
  return await productService.fetchProductsByCategory(categoryId); // Fetch products for the given category ID
});

