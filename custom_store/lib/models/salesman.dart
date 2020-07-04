import 'package:cloud_firestore/cloud_firestore.dart';

class Salesman{
  String name;
  double comission;

  Salesman({this.name, this.comission});

  Salesman fromMap(DocumentSnapshot map){
   return Salesman(name: map["name"], comission: double.parse(map["comission"]));
  }
}