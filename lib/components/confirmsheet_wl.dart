import 'package:appk_flutter/viewmodels/wishlist_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishConfirmSheet extends StatefulWidget {
  const WishConfirmSheet(
      {super.key,
      required this.userId,
      required this.wishId,
      required this.wishName});
  final int? wishId;
  final String userId;
  final String wishName;

  @override
  State<WishConfirmSheet> createState() => _WishConfirmSheetState();
}

class _WishConfirmSheetState extends State<WishConfirmSheet> {
  final WishListViewModel wishlistController = Get.put(WishListViewModel());

  int? id;
  String uid = '';
  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.wishId;
    uid = widget.userId;
    name = widget.wishName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Delete $name?'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff26619C)),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff26619C)),
                  onPressed: () {
                    // expenseVm.deleteExpense(docid);
                    wishlistController.deleteWishListItem(id!, uid);
                    Get.back();
                    Get.snackbar("Success", "$name Deleted",
                        backgroundColor: Colors.white,
                        icon: const Icon(Icons.verified_rounded));
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
