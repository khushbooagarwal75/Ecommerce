import 'package:ecommerce_app/model/wishlist_model.dart';
import 'package:pocketbase/pocketbase.dart';


class WishlistService {
  final PocketBase client;

  // Constructor accepting the PocketBase client
  WishlistService(this.client);

  // Add an item to the wishlist
  Future<void> addToWishlist(WishlistItem item) async {
    try {
      final record = await client.collection('wishlist_Products').create(body: item.toMap());
      print('Item added to wishlist: ${record.data}');
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  // Fetch wishlist items for a specific user
  Future<List<WishlistItem>> getWishlist(String userId) async {
    try {
      final records = await client.collection('wishlist_Products').getFullList(
        filter: 'userId = "$userId"',
      );
      return records.map((record) => WishlistItem.fromMap(record.data)).toList();
    } catch (e) {
      print('Error fetching wishlist: $e');
      return [];
    }
  }
}
