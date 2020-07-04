import 'package:customstore/models/salesman.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'salesman_controller.g.dart';

class SalesmanController = _SalesmanController with _$SalesmanController;

abstract class _SalesmanController with Store {

  final Salesman salesman;

  _SalesmanController({this.salesman}){
    if(salesman == null) {
      nameText = "";
      comissionText = "";
    }
    else{
      nameText = salesman.name;
      comissionText = salesman.comission.toStringAsFixed(2);
      comissionTextEditingController.text = comissionText;
      nameTextEditingController.text = nameText;
    }
  }

  @observable
  bool isLoading = false;

  @observable
  bool isEditing = false;

  @observable
  String nameText;

  @observable
  String comissionText;

  @computed
  bool get nameValidator => nameText == null || nameText.isEmpty;

  @computed
  bool get comissionValidator => double.tryParse(comissionText) == null;

  @action
  void changeName (String text) {
    nameText = text;
  }

  @action
  void changeComission (String text) {
    comissionText = text;
  }

  @action
  void resetFields(){
    changeName("");
    changeComission("");
    nameTextEditingController.clear();
    comissionTextEditingController.clear();
    focusNode.unfocus();
    editedDocumentId = null;
  }

  @action
  void setFields({String name, String comission, String documentID}){
    print("SET FIELDS");
    changeName(name);
    changeComission(comission);
    nameTextEditingController.text = nameText;
    comissionTextEditingController.text = comissionText;
    editedDocumentId = documentID;
    focusNode.requestFocus();
  }

  String onErrorName() {return nameValidator ? "Este campo é obrigatório!" : null;}

  String onErrorComission() { return comissionValidator ? "Valor inválido!" : null;}

  final nameTextEditingController = TextEditingController();

  final comissionTextEditingController = TextEditingController();

  final focusNode = FocusNode();

  String editedDocumentId;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SnackBar getSnackBar ({String message, SnackBarAction snackBarAction}){
    return SnackBar(duration: Duration(seconds: 2),content: Text(message),action: snackBarAction ?? null /*SnackBarAction(label: "DESFAZER", textColor: Colors.red, onPressed: () {  },)*/,backgroundColor: Colors.black,);
  }

}