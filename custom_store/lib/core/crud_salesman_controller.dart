import 'package:customstore/helpers/salesman_helper.dart';
import 'package:customstore/models/salesman.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'crud_salesman_controller.g.dart';

class CrudSalesmanController = _CrudSalesmanController with _$CrudSalesmanController;

abstract class _CrudSalesmanController with Store {


  SalesmanHelper _salesmanHelper;

  _CrudSalesmanController(){
    _salesmanHelper = SalesmanHelper();
  }

  @observable
  bool isLoading = false;

  Future<bool> update({String documentID, Salesman salesman}) async{
    bool success;
    isLoading = true;
    await _salesmanHelper.update(documentID, salesman).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> insert ({@required String categoryName,@required String comission}) async{
    bool success;
    isLoading = true;
    await _salesmanHelper.insert(categoryName, comission: comission).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> delete ({String documentID}) async{
    bool success;
    isLoading = true;
    await _salesmanHelper.delete(documentID).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

}