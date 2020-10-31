import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSold {
  String clientName;

  Timestamp timestamp;
  String categoryName;
  String selectedSize = "P";
  String selectedColor;
  String selectedAmount;
}
