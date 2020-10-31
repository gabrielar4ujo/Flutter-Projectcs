import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SalesCounterHelper implements CategoryHelperI {
  String userUID;
  final divider = "-";
  SalesCounterHelper() {
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(String documentID,
      {String amount, String productName}) async {
    bool success = true;
    try {
      await update(documentID, amount, productName: productName);

      DocumentReference documentReference = Firestore.instance
          .collection("stores")
          .document(userUID)
          .collection("salesCounter")
          .document(productName + divider + documentID);

      DocumentSnapshot snapShot = await documentReference.get();
      if (snapShot != null && int.parse(snapShot.data["counter"]) <= 0) {
        await documentReference.delete();
      }
    } catch (e) {
      success = false;
    }

    return success;
  }

  @override
  Future<bool> insert(String documentID,
      {@required String productName,
      @required String categoryName,
      @required String price,
      @required String amount,
      String urlPhoto}) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesCounter")
        .document(productName + divider + documentID)
        .setData({
          "lastModified": Timestamp.now(),
          "productName": productName,
          "categoryName": categoryName,
          "counter": amount,
          "price": price,
          "urlPhoto": urlPhoto
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
  Future<bool> update(String documentID, amount,
      {String productName, String price, String urlPhoto}) async {
    bool success = false;

    CollectionReference snapShot = Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesCounter")
        .reference();

    if (urlPhoto != null) {
      snapShot
          .document(productName + divider + documentID)
          .updateData({
            "lastModified": Timestamp.now(),
            "counter": amount,
            "price": price,
            "urlPhoto": urlPhoto
          })
          .whenComplete(() => success = true)
          .catchError((exception) {
            success = false;
          })
          .timeout(
              Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut),
              onTimeout: () {});
    } else if (price == null) {
      snapShot
          .document(productName + divider + documentID)
          .updateData({
            "lastModified": Timestamp.now(),
            "counter": amount,
          })
          .whenComplete(() => success = true)
          .catchError((exception) {
            success = false;
          })
          .timeout(
              Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut),
              onTimeout: () {});
    } else {
      snapShot
          .document(productName + divider + documentID)
          .updateData({
            "lastModified": Timestamp.now(),
            "counter": amount,
            "price": price,
          })
          .whenComplete(() => success = true)
          .catchError((exception) {
            success = false;
          })
          .timeout(
              Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut),
              onTimeout: () {});
    }
    return success;
  }

  Future<int> hasProduct(
      {@required String documentID, @required String productName}) async {
    int has = -1;
    final DocumentSnapshot snapShot = await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesCounter")
        .document(productName + divider + documentID)
        .get()
        .catchError((exception) {
      has = -1;
    });

    if (snapShot != null && snapShot.exists) {
      has = int.parse(snapShot.data["counter"]);
    }

    return has;
  }
}
