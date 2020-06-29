import 'dart:io';

import 'package:customstore/helpers/product_helper.dart';
import 'package:mobx/mobx.dart';

part 'crud_product_controller.g.dart';

class CrudProductController = _CrudProductController with _$CrudProductController;

abstract class _CrudProductController with Store {

  ProductHelper _productHelper;

  _CrudProductController(){
    _productHelper = ProductHelper();
  }

  @observable
  bool isLoading = false;

  Future<bool> update({String documentID, String categoryName}) async{
    bool success;
    isLoading = true;
    await _productHelper.update(documentID, categoryName).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> insert ({String categoryName}) async{
    bool success;
    isLoading = true;
    await _productHelper.insert(categoryName).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> delete ({String documentID}) async{
    bool success;
    isLoading = true;
    await _productHelper.delete(documentID).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }

/*  Future<List> savePictures({List pictures}) async{
    List result;
    isLoading = true;
    await _productHelper.savePictures(pictures: pictures).then((value){
      result = value;
      isLoading = false;
    });
    return result;
  }*/


  Future<String> savePictures({File pictures}) async{
    String result;
    isLoading = true;
    await _productHelper.savePictures(pictures: pictures).then((value){
      result = value;
      isLoading = false;
    });
    return result;
  }

}