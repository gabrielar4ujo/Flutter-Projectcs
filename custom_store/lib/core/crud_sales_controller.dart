import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/helpers/sales_helper.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'crud_sales_controller.g.dart';

class CrudSalesController = _CrudSalesController with _$CrudSalesController;

abstract class _CrudSalesController with Store {
  final SalesHelper _salesHelper;
  final CrudProductController _crudProductController;

  @observable
  bool isLoading = false;

  _CrudSalesController()
      : _salesHelper = SalesHelper(),
        _crudProductController = CrudProductController();

  Future<bool> removeFromStock({@required List productList}) async {
    log("Início");
    isLoading = true;
    bool sucess;
    for (Map productSoldMap in productList) {
      try {
        await Firestore.instance
            .collection("stores")
            .document(GetIt.I.get<ControllerLoginPage>().user.uid)
            .collection("stock")
            .document(productSoldMap["categoryID"])
            .get()
            .then((value) async {
          Map map = value["listProducts"];
          print(productSoldMap["productName"]);
          print(map[productSoldMap["productName"]]["features"]
                  [productSoldMap["selectedSize"]]
              [productSoldMap["selectedColor"]]["amount"]);
          map[productSoldMap["productName"]]["features"]
                  [productSoldMap["selectedSize"]]
              [productSoldMap["selectedColor"]]["amount"] = (int.parse(
                      map[productSoldMap["productName"]]["features"]
                              [productSoldMap["selectedSize"]]
                          [productSoldMap["selectedColor"]]["amount"]) -
                  int.parse(productSoldMap["selectedAmount"]))
              .toString();
          print(map[productSoldMap["productName"]]["features"]
                  [productSoldMap["selectedSize"]]
              [productSoldMap["selectedColor"]]["amount"]);

          await _crudProductController
              .update(
                  documentID: productSoldMap["categoryID"], productData: map)
              .then((value) => sucess = value);
        });
      } catch (e) {
        sucess = false;
      }
    }
    log("Fim");
    return sucess;
  }

  Future<bool> insert(
      {@required String categoryID,
      @required List productList,
      @required Salesman salesman,
      String discount}) async {
    bool success;
    removeFromStock(productList: productList).then((value) async {
      log("Value: $value");
      if (value) {
        await _salesHelper
            .insert(categoryID,
                productList: productList,
                salesman: salesman,
                discount: discount)
            .then((value) {
          success = value;
        });
      } else
        success = value;
    });
    isLoading = false;
    return success;

    // bool success;
    // isLoading = true;
    // await _salesHelper
    //     .insert(categoryID,
    //         productList: productList, salesman: salesman, discount: discount)
    //     .then((value) {
    //   success = value;
    //   isLoading = false;
    // });
    // return success;
  }
}
