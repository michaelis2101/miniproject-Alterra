import 'package:appk_flutter/models/wishlist_model.dart';
import 'package:get/get.dart';

class WishlistUpController extends GetxController {
  var selectedWishlist = WishListModel(
    id: 0,
    uid: '',
    itemname: '',
    price: '',
    description: '',
  ).obs;

  void updateSelectedWishlist(WishListModel wishlist) {
    selectedWishlist.value = wishlist;
  }
}
