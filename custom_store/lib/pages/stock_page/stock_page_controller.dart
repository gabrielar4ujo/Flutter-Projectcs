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


}
