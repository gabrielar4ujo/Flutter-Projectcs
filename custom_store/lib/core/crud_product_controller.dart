import 'dart:io';

import 'package:customstore/helpers/product_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'crud_product_controller.g.dart';

class CrudProductController = _CrudProductController
    with _$CrudProductController;

abstract class _CrudProductController with Store {
  final ProductHelper _productHelper;

  _CrudProductController() : _productHelper = ProductHelper();

  @observable
  bool isLoading = false;

  Future<bool> update({String documentID, Map productData}) async {
    bool success;
    isLoading = true;
    await _productHelper.update(documentID, productData).then((value) {
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> insert(
      {@required String categoryName, @required Map productData}) async {
    bool success;
    isLoading = true;
    await _productHelper
        .insert(categoryName, productData: productData)
        .then((value) {
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> delete({String documentID}) async {
    bool success;
    isLoading = true;
    await _productHelper.delete(documentID).then((value) {
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

  Future<String> savePictures({File pictures}) async {
    String result;
    isLoading = true;
    await _productHelper.savePictures(pictures: pictures).then((value) {
      result = value;
      isLoading = false;
    });
    return result;
  }

  Future deletePictures(String url) async {
    await _productHelper.deletePictures(url);
  }
}
