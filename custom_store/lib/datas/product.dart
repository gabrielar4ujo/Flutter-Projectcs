import 'package:customstore/datas/product_sold.dart';

class Product extends ProductSold{

  double price;
  int amount;
  String name;

  Product({this.price, this.amount, this.name});

  Map<String, dynamic> toJson(){
    return {
      "year" : this.year,
      "month" : this.month,
      "day" : this.day,
      "timeStamp" : this.timestamp,
      "name" : this.name,
      "price" : this.price,
      "salesAmount" : this.salesAmount,
      "salesman" : this.vendedor,
      "type" : this.type
    };
  }

}