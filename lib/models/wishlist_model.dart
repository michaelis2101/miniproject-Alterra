class WishListModel {
  int? id;
  String? uid;
  String? itemname;
  String? price;
  String? description;

  WishListModel({
    this.id,
    this.uid,
    this.itemname,
    this.price,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'itemname': itemname,
      'price': price,
      'description': description,
    };
  }

  WishListModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['uid'];
    itemname = map['itemname'];
    price = map['price'];
    description = map['description'];
  }

  WishListModel copyWith({
    int? id,
    String? uid,
    String? itemname,
    String? price,
    String? description,
  }) {
    return WishListModel(
        uid: uid ?? this.uid,
        itemname: itemname ?? this.itemname,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
