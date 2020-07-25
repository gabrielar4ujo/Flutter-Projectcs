import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'stock_page_controller.g.dart';

class StockPageController = _StockPageController with _$StockPageController;

abstract class _StockPageController with Store {
  //ControllerLoginPage controllerLoginPage;
  //CategoryHelper categoryHelper;

  _StockPageController() {
    //controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    //categoryHelper = CategoryHelper(userUID: controllerLoginPage.user.uid);
  }

  TextEditingController textEditingController = TextEditingController();

  void textFormFieldClear() {
    textEditingController.clear();
    _productText = "";
    print("clear");
  }

  /* @observable
  bool isLoading = false;*/

  @observable
  bool _wasEdited = false;

  @computed
  bool get wasEdited => _wasEdited;

  @action
  void changeWasEdited(String lastName) {
    _wasEdited = lastName != textEditingController.text;
  }

  @observable
  String _productText = '';

  @computed
  String get productText => _productText;

  @action
  void setProductText(String currentName, String lastName) {
    _productText = currentName;
    changeWasEdited(lastName);
  }

  @computed
  bool get productTextValidator => _productText.isEmpty;

  String productValidator() {
    if (productTextValidator) return "Nome inválido";
    return null;
  }

  /* void confirmed() async {

    bool categoryExist = false;
    String categoryName = _productText;

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
        //insert(categoryName);
      }
    });
  }

  Future<bool> update( String documentID) async{
    bool sucess;
    isLoading = true;
    await categoryHelper.update(documentID, _productText).then((value){
      sucess = value;
      isLoading = false;
    });
    return sucess;
  }

  Future<bool> insert () async{
    bool success;
    isLoading = true;
    await categoryHelper.insert(_productText).then((value){
      success = value;
      isLoading = false;
    });
    return success;
  }*/

}
