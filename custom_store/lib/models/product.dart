import 'package:basic_utils/basic_utils.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
//import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> origin
import 'package:flutter/cupertino.dart';

import 'product_sold.dart';

class Product extends ProductSold {
  double price;
  int amount;
  String name;
  String categoryId;
  List listPictures;
  double spent;
  Map<String, dynamic> features;

  Product(
      {this.price,
      this.amount,
      this.name,
      this.categoryId,
      this.listPictures,
      this.spent,
      this.features});

  Map<String, dynamic> toJson() {
    return {
      "price": this.price.toString(),
      "amount": this.amount.toString(),
      "pictures": this.listPictures,
      "spent": this.spent.toString(),
      "features": this.features ?? Map()
    };
  }

  void fromJson({String nameProduct, Map map, String categoryName}) {
    this.name = nameProduct;
    this.features = map["features"];
    this.amount = int.parse(map["amount"]);
    super.categoryName = categoryName;
  }

  List getListColorProductPage(String size) {
    List listColorProductPage = List();
    if (!features.containsKey(size)) return listColorProductPage;
    this.features[size].forEach((key, value) {
      listColorProductPage.add([StringUtils.capitalize(key), value["amount"]]);
    });
    print("GETLISTPRODUCTPAGE");
    print(listColorProductPage);
    return listColorProductPage;
  }

  void setAmount({@required Map<String, dynamic> featuresMap}) {
    amount = 0;
    featuresMap.forEach((key, value) {
      value.forEach((color, amount) {
        this.amount += int.parse(amount["amount"]);
      });
    });
    print(amount);
  }

  @override
  String toString() {
    return "\n##############\nName: $name\nPrice: $price\nAmount: $amount\nSpent: $spent\nPictures: $listPictures\nFeatures: $features\n##############\n\n";
  }
}
