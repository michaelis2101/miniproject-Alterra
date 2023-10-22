import 'package:appk_flutter/controller/wishlist_upstate.dart';
import 'package:appk_flutter/models/wishlist_model.dart';
import 'package:appk_flutter/viewmodels/wishlist_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishUpdate extends StatefulWidget {
  const WishUpdate({super.key});

  @override
  State<WishUpdate> createState() => _WishUpdateState();
}

class _WishUpdateState extends State<WishUpdate> {
  final WishlistUpController updateWish = Get.put(WishlistUpController());
  final WishListViewModel funcWishUpdate = Get.put(WishListViewModel());
  TextEditingController nameCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  @override
  void initState() {
    final selectedWish = updateWish.selectedWishlist.value;
    super.initState();
    nameCont.text = selectedWish.itemname!;
    priceCont.text = selectedWish.price!;
    descCont.text = selectedWish.description!;
  }

  @override
  Widget build(BuildContext context) {
    final selectedWish = updateWish.selectedWishlist.value;
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
          backgroundColor: const Color(0xff26619C),
          title: const Text(
            'Update Wishlist',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          )),
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
                        _updateWish();
                        Get.back();
                        Get.snackbar('Succes', 'Item Updated',
                            backgroundColor: Colors.white,
                            icon: const Icon(Icons.verified));
                      }
                    },
                    child: const Text(
                      'Update Wish',
                      style: TextStyle(color: Color(0xff26619C)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateWish() {
    final selectedWish = updateWish.selectedWishlist.value;

    WishListModel newWish = WishListModel(
      id: selectedWish.id,
      uid: selectedWish.uid,
      itemname: nameCont.text,
      price: priceCont.text,
      description: descCont.text,
    );

    funcWishUpdate.updateWishListItem(newWish, selectedWish.uid.toString());
    print(selectedWish);
  }
}
