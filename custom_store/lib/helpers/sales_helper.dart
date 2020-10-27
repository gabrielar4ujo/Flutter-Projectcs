import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';

import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class SalesHelper implements CategoryHelperI {
  String userUID;

  SalesHelper() {
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(
    String documentID, {
    @required String month,
    @required int index,
  }) async {
    bool success = false;
    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("sales")
        .document(documentID)
        .get()
        .then((value) async {
      print(value.documentID);
      if (value != null) {
        List productList = value.data[month];
        productList.removeAt(index);
        await update(documentID, productList);
      }
    });

    return success;
  }

  @override
  Future<bool> insert(String documentID,
      {@required List productList,
      @required Salesman salesman,
      String discount}) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("sales")
        .document()
        .setData({
          "time": Timestamp.now(),
          DateTime.now().month.toString(): [
            {
              "time": Timestamp.now(),
              "discount": discount,
              "productList": productList,
              "salesmanName": salesman.name,
              "salesmanComission": salesman.comission.toString(),
              "clientName": salesman.clientName,
            }
          ]
        })
        .whenComplete(() => success = true)
        .catchError((exception) {
          success = false;
        })
        .timeout(Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut),
            onTimeout: () {});

    return success;
  }

  @override
  Future<bool> update(String documentID, listSales) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("sales")
        .document(documentID)
        .updateData({DateTime.now().month.toString(): listSales})
        .whenComplete(() => success = true)
        .catchError((exception) {
          success = false;
        })
        .timeout(Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut),
            onTimeout: () {});

    return success;
  }
}
