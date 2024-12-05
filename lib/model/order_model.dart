class Order {
  final String id;
  final String productId;
  final String userEmail;
  final String paymentMode;
  final String paymentStatus;

  Order({
    required this.id,
    required this.productId,
    required this.userEmail,
    required this.paymentMode,
    required this.paymentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      userEmail: json['userEmail'] ?? '',
      paymentMode: json['paymentMode'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
    );
  }
}
