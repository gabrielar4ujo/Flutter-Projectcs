
import 'package:basic_utils/basic_utils.dart';

import 'product_sold.dart';

class Product extends ProductSold{

  double price;
  int amount;
  String name;
  String categoryId;
  List listPictures;
  double spent;
  Map<String,dynamic> features;

  Product({this.price, this.amount, this.name, this.categoryId, this.listPictures, this.spent, this.features});

  Map<String, dynamic> toJson(){
    return {
      "price" : this.price.toString(),
      "amount" : this.amount.toString(),
      "pictures" : this.listPictures,
      "spent" : this.spent.toString(),
      "features" : this.features ?? Map()
    };
  }

  List getListColorProductPage (String size){
    List listColorProductPage = List();
    if(!features.containsKey(size)) return listColorProductPage;
    this.features[size].forEach((key, value) {
      listColorProductPage.add([StringUtils.capitalize(key),value["amount"]]);
    });
    print("GETLISTPRODUCTPAGE");
    print(listColorProductPage);
    return listColorProductPage;
  }

  @override
  String toString() {
    return "Name: $name\nPrice: $price\nAmount: $amount\nSpent: $spent\nPictures: $listPictures\nFeatures: $features";
  }



}