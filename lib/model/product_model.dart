class Product {
  final String id;
  final String product_name;
  final double product_price;
  final String product_desc;
  final String product_image;

  Product({
    required this.id,
    required this.product_name,
    required this.product_price,
    required this.product_desc,
    required this.product_image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      product_name: json['product_name'],
      product_price: double.tryParse(json['product_price'].toString()) ?? 0.0,
      product_desc: json['product_desc'] ?? '',
      product_image: json['product_image'] ?? '',
    );
  }

  // Method to generate full image URL
  String getImageUrl(String baseUrl) {
    return '$baseUrl/api/files/products/$id/$product_image';
  }
}
