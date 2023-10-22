import 'package:appk_flutter/controller/wishlist_upstate.dart';
import 'package:appk_flutter/screens/getrecwish.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailWish extends StatefulWidget {
  const DetailWish({super.key});

  @override
  State<DetailWish> createState() => _DetailWishState();
}

class _DetailWishState extends State<DetailWish> {
  final WishlistUpController detailWish = Get.put(WishlistUpController());
  String? itemName;
  String? itemPrice;
  String? itemDesc;

  Color lapisLazuli = const Color(0xff26619C);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final wishData = detailWish.selectedWishlist.value;

    setState(() {
      itemName = wishData.itemname;
      itemPrice = wishData.price;
      itemDesc = wishData.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
        title: const Text(
          "Detail Wish",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff26619C),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Item Name',
                          //   style: TextStyle(fontSize: 20, color: lapisLazuli),
                          // ),
                          Text(
                            itemName.toString(),
                            style: TextStyle(fontSize: 25, color: lapisLazuli),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Price : Rp. ${itemPrice.toString()}',
                            style: TextStyle(fontSize: 20, color: lapisLazuli),
                          ),
                          // Text(
                          //   'Rp. ${itemPrice.toString()}',
                          //   style: TextStyle(fontSize: 18, color: lapisLazuli),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(fontSize: 20, color: lapisLazuli),
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(color: lapisLazuli),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      itemDesc.toString(),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: Text(
                          'Back',
                          style: TextStyle(color: lapisLazuli),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const PlannerFromWish()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: Text(
                          'GetRec',
                          style: TextStyle(color: lapisLazuli),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
