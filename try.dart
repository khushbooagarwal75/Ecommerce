import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateUser1(String userId, Map<String, dynamic> data) async {
  final baseUrl = "http://192.168.207.32:8090";
  final endpoint = "/api/collections/users/records/$userId";
  final url = Uri.parse("$baseUrl$endpoint");

  try {
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update user: ${response.body}");
    }

    print("User updated successfully: ${response.body}");
  } catch (e) {
    print("Error updating user: $e");
    rethrow;
  }
}
