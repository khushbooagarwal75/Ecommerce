import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationController, bool>((ref) {
  return NavigationController();
});

class NavigationController extends StateNotifier<bool> {
  NavigationController() : super(false) {
    _initSplashScreen();
  }

  void _initSplashScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Splash duration
    state = true; // Change state to true to navigate to the home screen
  }
}
