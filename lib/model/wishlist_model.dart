class WishlistItem {
  final String userId;
  final String productId;

  WishlistItem({
    required this.userId,
    required this.productId,
  });

  // Convert a PocketBase record into a WishlistItem
  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(

      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',

    );
  }

  // Convert a WishlistItem to a map for PocketBase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
    };
  }
}
