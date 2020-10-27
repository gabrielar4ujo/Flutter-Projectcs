import 'package:customstore/helpers/sales_counter_helper.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'crud_sales_counter_controller.g.dart';

class CrudSalesCounterController = _CrudSalesCounterControllerBase
    with _$CrudSalesCounterController;

abstract class _CrudSalesCounterControllerBase with Store {
  final SalesCounterHelper _saleCounter;

  @observable
  bool isLoading = false;

  _CrudSalesCounterControllerBase() : _saleCounter = SalesCounterHelper();

  Future<bool> update() async {
    throw UnimplementedError();
  }

  Future<bool> delete(
      {@required String documentID,
      @required String amount,
      @required String productName}) async {
    isLoading = true;

    bool success;
    try {
      int has = await _saleCounter.hasProduct(
          documentID: documentID, productName: productName);
      if (has == -1) return false;
      await _saleCounter
          .delete(documentID,
              amount: (has - int.parse(amount)).toString(),
              productName: productName)
          .then((value) => success = value);
    } catch (e) {
      isLoading = false;
      success = false;
    }
    isLoading = false;
    return success;
  }

  Future<bool> insert(String documentID,
      {@required String productName,
      @required String categoryName,
      @required String price,
      @required String amount,
      String urlPhoto}) async {
    isLoading = true;
    bool success;

    try {
      int has = await _saleCounter.hasProduct(
          documentID: documentID, productName: productName);
      print(has);
      if (has != -1) {
        await _saleCounter
            .update(documentID, (int.parse(amount) + has).toString(),
                productName: productName, price: price, urlPhoto: urlPhoto)
            .then((value) => success = value);
      } else {
        await _saleCounter
            .insert(documentID,
                productName: productName,
                categoryName: categoryName,
                price: price,
                amount: amount,
                urlPhoto: urlPhoto)
            .then((value) => success = value);
      }
    } catch (e) {
      isLoading = false;
      success = false;
    }

    isLoading = false;
    return success;
  }
}
