import 'package:appk_flutter/helper/db_helper.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/models/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class WishListViewModel extends GetxController {
  final items = <WishListModel>[].obs;
  final UserController c = Get.put(UserController());

  // final userid

  @override
  void onInit() {
    super.onInit();
    loadWishListItems(c.uid.toString());
  }

  Future<void> loadWishListItems(String userUid) async {
    final database = await DatabaseProvider.db.database;
    final result =
        await database?.query('wishlist', where: 'uid=?', whereArgs: [userUid]);
    items
        .assignAll(result!.map((item) => WishListModel.fromMap(item)).toList());
  }

  Future<void> addItemToWishList(WishListModel item, String userUid) async {
    final database = await DatabaseProvider.db.database;
    await database?.insert('wishlist', item.toMap());
    loadWishListItems(userUid);
  }

  Future<void> updateWishListItem(WishListModel item, String userUid) async {
    final database = await DatabaseProvider.db.database;
    await database?.update('wishlist', item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
    loadWishListItems(userUid);
  }

  Future<void> deleteWishListItem(int id, String userUid) async {
    final database = await DatabaseProvider.db.database;
    await database?.delete('wishlist', where: 'id = ?', whereArgs: [id]);
    loadWishListItems(userUid);
  }
}
