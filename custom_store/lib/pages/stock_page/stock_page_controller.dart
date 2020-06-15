import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'stock_page_controller.g.dart';

class StockPageController = _StockPageController with _$StockPageController;

abstract class _StockPageController with Store {

  final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();

  @observable
  String productText = '';

  @computed
  String get getPd => productText;

  @action
  void setProductText(String s){
    productText = s;
  }

  @computed
  bool get productTextValidator => productText.isEmpty;


  String productValidator(){
    if(productTextValidator) return "Nome inválido";
    return null;
  }

  void dialogConfirm() async {

    bool categoryExist = false;
    String categoryName = productText;

    await Firestore.instance
        .collection("stores")
        .document(controllerLoginPage.user.uid)
        .collection("stock").getDocuments().then((value) async {
      value.documents.forEach((element) {
        if (element.data["categoryName"] == categoryName) {
          print("has exist");
          categoryExist = true;
          return;
        }
      });

      if (!categoryExist) {
        print("dont exist");
        await Firestore.instance
            .collection("stores")
            .document(controllerLoginPage.user.uid)
            .collection("stock").document().setData({
          "categoryName": categoryName
        });
      }
    });
  }
}