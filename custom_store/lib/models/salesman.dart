import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/salesman_sold.dart';

class Salesman extends SalesmanSold{
  String name;
  double comission;

  Salesman({this.name, this.comission});

  Salesman fromMap(DocumentSnapshot map){
   return Salesman(name: map["name"], comission: double.parse(map["comission"]));
  }
}
