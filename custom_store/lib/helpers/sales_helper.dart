import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class SalesHelper implements CategoryHelperI {

  String userUID;
  final timeOut = 3;

  SalesHelper(){
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(String documentID) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(String documentID, {@required  Product productData}) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("sales").document().setData({
      "categoryID" : productData.categoryId,
      "categoryName": productData.categoryName,
      "productName": productData.name,
      "selectedSize": productData.selectedSize,
      "selectedColor": productData.selectedColor,
      "selectedAmount": productData.selectedAmount,
      "salesmanName": productData.salesman.name,
      "salesmanComission": productData.salesman.comission.toString(),
      "clientName": productData.clientName,
    }).whenComplete(() =>  success = true ).catchError((exception){
      success = false;
    }).timeout(Duration(seconds: timeOut), onTimeout: (){
      print("PRODUCT TIMEOUT");
    });

    return success;
  }

  @override
  Future<bool> update(String documentID, data) {
    // TODO: implement update
    throw UnimplementedError();
  }

}