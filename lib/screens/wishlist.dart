import 'package:appk_flutter/controller/wishlist_upstate.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/models/wishlist_model.dart';
import 'package:appk_flutter/screens/addwishlist.dart';
import 'package:appk_flutter/screens/detail_wish.dart';
import 'package:appk_flutter/screens/update_wish.dart';
import 'package:appk_flutter/viewmodels/wishlist_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListViewModel wishlistController = Get.put(WishListViewModel());
  final UserController c = Get.put(UserController());
  final WishlistUpController wish = Get.put(WishlistUpController());

  @override
  Widget build(BuildContext context) {
    String userid = c.uid.toString();
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
        backgroundColor: const Color(0xff26619C),
        title: const Text(
          'Wishlist',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: Obx(() {
        if (wishlistController.items.isEmpty) {
          return const Center(
            child: Text(
              'No items found',
              style: TextStyle(fontSize: 30),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                // padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                  itemCount: wishlistController.items.length,
                  itemBuilder: (context, index) {
                    final wishlist = wishlistController.items[index];
                    return ListTile(
                      title: Text(wishlist.itemname.toString()),
                      subtitle: Text(wishlist.price.toString()),
                      onTap: () {
                        // wish.selectedWishlist(wishlist);
                        wish.selectedWishlist(wishlist);
                        Get.to(() => const DetailWish());
                      },
                      trailing: Wrap(children: [
                        IconButton(
                            onPressed: () {
                              wishlistController.deleteWishListItem(
                                  wishlist.id!, userid);
                            },
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              var updateWish = WishListModel(
                                id: wishlist.id,
                                uid: wishlist.uid,
                                itemname: wishlist.itemname,
                                price: wishlist.price,
                                description: wishlist.description,
                              );

                              wish.selectedWishlist(updateWish);

                              Get.to(() => const WishUpdate());
                            },
                            icon: const Icon(Icons.edit))
                      ]),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Get.to(() => const AddWishlist()),
        child: const Icon(
          Icons.add,
          color: Color(0xff26619C),
        ),
      ),
    );
  }
}
