// import 'package:ecommerce_app/Services/auth_service.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // Initialize the PocketBase service
// final pocketBaseAuthProvider = Provider(
//         (ref) => PocketBaseAuthService('http://10.0.2.2:8090/_/#/'),
// );
//
// // User authentication state provider
// final userAuthStateProvider = StateProvider<bool>((ref) => false);

import 'dart:io';
import 'package:ecommerce_app/Services/auth_service.dart';
import 'package:ecommerce_app/Services/category_service.dart';
import 'package:ecommerce_app/Services/product__service.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Determine the appropriate base URL based on the platform
String getBaseUrl() {
  switch (Platform.operatingSystem) {
    case 'android':
      return 'http://10.0.2.2:8090';
    case 'ios':
      return 'http://127.0.0.1:8090';
    default:
      return 'http://127.0.0.1:8090';
  }
}

// PocketBase Service Provider
final pocketBaseAuthProvider = Provider(
      (ref) => PocketBaseAuthService(getBaseUrl()),
);


// Registration Provider
final registerUserProvider = FutureProvider.family<void, Map<String, String>>((ref, credentials) {
  final authService = ref.read(pocketBaseAuthProvider);
  return authService.registerUser(credentials['email']!, credentials['password']!);
});

// Login Provider
final loginUserProvider = FutureProvider.family<void, Map<String, String>>((ref, credentials) {
  final authService = ref.read(pocketBaseAuthProvider);
  return authService.loginUser(credentials['email']!, credentials['password']!);
});


final pocketBaseServiceProvider = Provider(
      (ref) => PocketBaseService(getBaseUrl()),
);

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.watch(pocketBaseServiceProvider);
  return await service.fetchProducts();
});

final categoryServiceProvider = Provider(
      (ref) => CategoryService(getBaseUrl()),
);

final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final categoryService = ref.watch(categoryServiceProvider);
  return await categoryService.fetchCategories();
});



