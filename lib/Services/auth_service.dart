import 'package:pocketbase/pocketbase.dart';

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
  }

// Add additional methods if needed...
}
