import 'dart:math';

import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/models/wishlist_model.dart';
import 'package:appk_flutter/viewmodels/wishlist_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddWishlist extends StatefulWidget {
  const AddWishlist({super.key});

  @override
  State<AddWishlist> createState() => _AddWishlistState();
}

class _AddWishlistState extends State<AddWishlist> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  final UserController c = Get.put(UserController());
  final WishListViewModel wishlistCont = Get.put(WishListViewModel());

  int randomID = 0;

  int generateRandomIntId(int length) {
    Random random = Random();
    int min = 0;
    int max = pow(10, length)
        .toInt(); // Calculate the maximum value based on the desired length

    return min + random.nextInt(max - min);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      randomID = generateRandomIntId(8);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCont.dispose();
    priceCont.dispose();
    descCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
        backgroundColor: const Color(0xff26619C),
        title: const Text(
          'Add Wishlist',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Item Name',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              TextField(
                controller: nameCont,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: Color(0xff26619C),
                  labelStyle: TextStyle(color: Color(0xff26619C)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: Color(0xff26619C)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusColor: Color(0xff26619C),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Item Name',
                  prefixIcon: Icon(Icons.favorite_rounded),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Price',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              TextField(
                controller: priceCont,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: Color(0xff26619C),
                  labelStyle: TextStyle(color: Color(0xff26619C)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: Color(0xff26619C)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusColor: Color(0xff26619C),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Item Price',
                  prefixIcon: Icon(Icons.price_change_rounded),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Decsription',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              SizedBox(
                height: 300,
                child: TextField(
                  // style: TextStyle(),
                  maxLines: 10,
                  controller: descCont,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIconColor: Color(0xff26619C),
                    labelStyle: TextStyle(color: Color(0xff26619C)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.0, color: Color(0xff26619C)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusColor: Color(0xff26619C),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Item Description',
                    // prefixIcon: Icon(Icons.note),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (nameCont.text.isEmpty ||
                          priceCont.text.isEmpty ||
                          descCont.text.isEmpty) {
                        Get.snackbar('Error', 'Please fill the fields',
                            backgroundColor: Colors.white,
                            icon: const Icon(Icons.warning));
                      } else {
                        _addWishlist();
                        Get.back();
                        Get.snackbar('Success', 'Item Added To the Wishlist',
                            backgroundColor: Colors.white,
                            icon: const Icon(Icons.verified));
                      }
                    },
                    child: const Text(
                      'Add to Wishlist',
                      style: TextStyle(color: Color(0xff26619C)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addWishlist() async {
    String userid = c.uid.toString();
    final itemName = nameCont.text;
    final itemPrice = priceCont.text;
    final itemDescription = descCont.text;

    final newWishlist = WishListModel(
        id: randomID,
        uid: c.uid.toString(),
        itemname: nameCont.text,
        description: descCont.text,
        price: itemPrice);
    await wishlistCont.addItemToWishList(newWishlist, userid);
    // Get.snackbar('Success', 'Item Added To the Wishlist',
    //     backgroundColor: Colors.white, icon: const Icon(Icons.verified));
  }
}
