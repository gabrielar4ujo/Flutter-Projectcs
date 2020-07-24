import 'package:customstore/helpers/sales_helper.dart';
import 'package:customstore/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'crud_sales_controller.g.dart';

class CrudSalesController = _CrudSalesController with _$CrudSalesController;

abstract class _CrudSalesController with Store {

  final SalesHelper _salesHelper;

  @observable
  bool isLoading = false;

  _CrudSalesController() : _salesHelper = SalesHelper();

  Future<bool> insert ({@required String categoryName,@required Product productData}) async{
    bool success;
    isLoading = true;
    await _salesHelper.insert(categoryName, productData: productData).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

}