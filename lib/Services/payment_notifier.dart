import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentOptionNotifier extends StateNotifier<String?> {
  PaymentOptionNotifier() : super(null);

  // Method to select a payment option
  void selectPaymentOption(String paymentMethod) {
    state = paymentMethod;
  }

  // Method to reset the payment option
  void resetPaymentOption() {
    state = null;
  }
}

final paymentOptionProvider = StateNotifierProvider<PaymentOptionNotifier, String?>((ref) {
  return PaymentOptionNotifier();
});
