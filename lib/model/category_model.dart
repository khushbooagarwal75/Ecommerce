class Category {
  final String id;
  final String category_name;
  final String category_image;

  Category({
    required this.id,
    required this.category_name,
    required this.category_image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category_name: json['category_name'],
      category_image: json['category_image'] ?? '',
    );
  }

  // Method to generate full image URL
  String getImageUrl(String baseUrl) {
    return '$baseUrl/api/files/categories/$id/$category_image';
  }
}
