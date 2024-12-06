import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentOptionNotifier extends StateNotifier<String?> {
  PaymentOptionNotifier() : super(null);

  void selectPaymentOption(String paymentMethod) {
    state = paymentMethod;
  }

  void resetPaymentOption() {
    state = null;
  }
}

final paymentOptionProvider = StateNotifierProvider<PaymentOptionNotifier, String?>((ref) {
  return PaymentOptionNotifier();
});
