import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PocketBaseAuthService {
  final String baseUrl;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  PocketBaseAuthService(this.baseUrl);

  // Register a new user
  Future<String> registerUser(String email, String password) async {
    print(baseUrl);
    final url = Uri.parse('$baseUrl/api/collections/users/records');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'passwordConfirm': password,
      }),
    );

    if (response.statusCode == 200) {
      return 'Registration successful!';
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  // Log in a user
  Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/collections/users/auth-with-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identity': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'auth_token', value: data['token']);
      return 'Login successful!';
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Validate the logged-in user
  Future<bool> validateUser() async {
    final token = await _storage.read(key: 'auth_token');
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/api/collections/users/auth-refresh');
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 200;
  }

  // Logout user
  Future<void> logoutUser() async {
    await _storage.delete(key: 'auth_token');
  }
}
