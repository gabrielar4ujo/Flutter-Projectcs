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
          Map allSalesMap = value.data["listProducts"];
          int amount = int.parse(allSalesMap[productSoldMap["productName"]]
                  ["features"][productSoldMap["selectedSize"]]
              [productSoldMap["selectedColor"]]["amount"]);

          allSalesMap[productSoldMap["productName"]]["features"]
                      [productSoldMap["selectedSize"]]
                  [productSoldMap["selectedColor"]]["amount"] =
              (amount - (int.parse(productSoldMap["selectedAmount"])))
                  .toString();

          await _crudProductController
              .update(
                  documentID: productSoldMap["categoryID"],
                  productData: allSalesMap)
              .then((value) => sucess = value);
        });
      } catch (e) {
        sucess = false;
      }
    }

    return sucess;
  }

  Future<bool> update(
      {@required String documentID,
      @required List listSales,
      @required int index,
      String discount}) async {
    //print("-----------\nUPDATE\n------------");
    bool sucess;
    //print(listSales[index]["productList"]);
    removeFromStock(productList: listSales[index]["productList"])
        .then((value) async {
      if (value) {
        print("Consegui remover do stock");
        _salesHelper.update(documentID, listSales).then((value) {
          sucess = value;
        });
      } else {
        print("Não consegui remover do stock");
        sucess = value;
      }
    });
    isLoading = false;
    return sucess;
  }

  Future<bool> putBackInStock({@required List productList}) async {
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
          Map allSalesMap = value.data["listProducts"];
          int amount = int.parse(allSalesMap[productSoldMap["productName"]]
                  ["features"][productSoldMap["selectedSize"]]
              [productSoldMap["selectedColor"]]["amount"]);

          allSalesMap[productSoldMap["productName"]]["features"]
                      [productSoldMap["selectedSize"]]
                  [productSoldMap["selectedColor"]]["amount"] =
              (amount + (int.parse(productSoldMap["selectedAmount"])))
                  .toString();

          await _crudProductController
              .update(
                  documentID: productSoldMap["categoryID"],
                  productData: allSalesMap)
              .then((value) => sucess = value);
        });
      } catch (e) {
        sucess = false;
      }
    }

    return sucess;
  }

  Future<bool> delete({
    @required List productList,
    @required String documentID,
    @required String month,
    @required int index,
  }) async {
    bool sucess = false;
    // print(documentID);
    // print(month);
    // print(index);
    await putBackInStock(productList: productList).then((value) async {
      await _salesHelper
          .delete(documentID, month: month, index: index)
          .then((value) => sucess = value);
    });
    isLoading = false;

    return sucess;
  }

  Future<bool> insert(
      {@required String documentID,
      @required List productList,
      @required Salesman salesman,
      String discount}) async {
    print("-----------\nINSERT\n------------");
    bool success;
    removeFromStock(productList: productList).then((value) async {
      if (value) {
        await _salesHelper
            .insert(documentID,
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
