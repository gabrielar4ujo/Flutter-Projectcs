
import 'product_sold.dart';

class Product extends ProductSold{

  double price;
  int amount;
  String name;
  String categoryId;
  List listPictures;
  double spent;

  Product({this.price, this.amount, this.name, this.categoryId, this.listPictures, this.spent});

  Map<String, dynamic> toJson(){
    return {
      "price" : this.price.toString(),
      "amount" : this.amount.toString(),
      "pictures" : this.listPictures
    };
  }

  @override
  String toString() {
    return "Name: $name\nPrice: $price\nAmount: $amount\nPictures: $listPictures";
  }


}