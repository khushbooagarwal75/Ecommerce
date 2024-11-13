import 'package:ecommerce_app/forgotPassword.dart';
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/navigation/navigation_provider.dart';
import 'package:ecommerce_app/signUp.dart';
import 'package:ecommerce_app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp( ProviderScope(child:  MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showHomeScreen = ref.watch(navigationProvider);

    return MaterialApp(
      home: showHomeScreen ? Splashscreen() :  Splashscreen(),
    );
  }
}

