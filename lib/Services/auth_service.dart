import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseAuthService {
  final PocketBase client;

  PocketBaseAuthService(this.client);

  // Register a new user
  Future<void> registerUser(String email, String password) async {
    await client.collection('users').create(body: {
      'email': email,
      'password': password,
      'passwordConfirm': password,
    });
  }

  // Log in a user
  Future<void> loginUser(String email, String password) async {
    await client.collection('users').authWithPassword(email, password);
    _userEmail = email; // Store the logged-in user's email
  }

  String? _userEmail;

  String? get loggedInUserEmail => _userEmail;

  // Logout the user
  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String? getLoggedInUserId() {
    return client.authStore.model?.id;
  }
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      final response = await client.collection('users').update(userId, body: data);
      print("User data: $data");
      print("User data updated successfully: $response");
    }
    catch (e) {
      // Log the error for debugging purposes
      print("Error updating user: $e");
      // Optionally, you can rethrow the error to handle it elsewhere
      rethrow;
    }
  }
}
