import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseAuthService {
  final PocketBase client;

  PocketBaseAuthService(this.client);

  Future<void> registerUser(String email, String password) async {
    await client.collection('users').create(body: {
      'email': email,
      'password': password,
      'passwordConfirm': password,
    });
  }

  Future<void> loginUser(String email, String password) async {
    await client.collection('users').authWithPassword(email, password);
    _userEmail = email; // Store the logged-in user's email
  }

  String? _userEmail;

  String? get loggedInUserEmail => _userEmail;


  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String? getLoggedInUserId() {
    return client.authStore.model?.id;
  }

  Future<bool> checkUserExists(String userId) async {
    try {
      // Use getOne to fetch the user by their ID
      final response = await client.collection('users').getOne(userId);
      return response != null;  // Return true if user exists
    } catch (e) {
      // Error indicates that the user doesn't exist
      print("Error: User not found. $e");
      return false;  // Return false if user doesn't exist
    }
  }

  Future<void> updateRecord(String recordId, Map<String, dynamic> data) async {
    try {
      final userExists = await checkUserExists(recordId);
      if (!userExists) {
        print("User does not exist.");
        return;
      }
      final updatedRecord = await client.collection('users').update(recordId, body: data);
      print("Record updated: $updatedRecord");
    } catch (e) {
        print("Error updating record: $e");
      // }
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String recordId) async {
    try {
      final record = await client.collection('users').getOne(
        recordId,
        expand: 'relField1,relField2.subRelField', // Adjust fields as needed
      );
      print("Fetched user details: ${record.toJson()}");
      return record.toJson(); // Return the record data to the caller
    } catch (e) {
      print("Error fetching user details: $e");
      throw Exception("Fetching user details failed.");
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    try {
      await client.collection('users').requestPasswordReset(email.trim());
      return true;
    } catch (error) {
      print("Error sending reset email: $error");
      return false;
    }
  }

  Future<void> confirmPasswordReset(String resetToken, String newPassword) async {
    try {
      await client.collection('users').confirmPasswordReset(
        resetToken,
        newPassword,
        newPassword,
      );
      print("Password reset successfully.");
    } catch (error) {
      print("Error resetting password: $error");
      rethrow;
    }
  }

}
