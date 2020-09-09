import 'package:customstore/models/salesman.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'salesman_controller.g.dart';

class SalesmanController = _SalesmanController with _$SalesmanController;

abstract class _SalesmanController with Store {
  final Salesman salesman;

  _SalesmanController({this.salesman}) {
    if (salesman == null) {
      nameText = "";
      comissionText = "";
    } else {
      nameText = salesman.name;
      comissionText = salesman.comission.toStringAsFixed(2);
      comissionTextEditingController.text = comissionText;
      nameTextEditingController.text = nameText;
    }
  }

  @observable
  bool showErrorName = false;

  @observable
  bool showErrorComission = false;

  @observable
  bool isLoading = false;

  @observable
  bool isEditing = false;

  @observable
  String nameText;

  @observable
  String comissionText;

  @computed
  bool get nameValidator =>
      (nameText == null || nameText.isEmpty) && showErrorName;

  @computed
  bool get comissionValidator =>
      (double.tryParse(comissionText) == null) && showErrorComission;

  @computed
  bool get enableButton =>
      !(nameValidator || comissionValidator) &&
      (showErrorComission && showErrorName);

  @action
  void changeName(String text) {
    showErrorName = true;
    nameText = text;
  }

  @action
  void changeComission(String text) {
    showErrorComission = true;
    comissionText = text;
  }

  @action
  void resetFields() {
    changeName("");
    changeComission("");
    nameTextEditingController.clear();
    comissionTextEditingController.clear();
    focusNode.unfocus();
    editedDocumentId = null;
    showErrorComission = false;
    showErrorName = false;
  }

  @action
  void setFields({String name, String comission, String documentID}) {
  
    changeName(name);
    changeComission(comission);
    nameTextEditingController.text = nameText;
    comissionTextEditingController.text = comissionText;
    editedDocumentId = documentID;
    focusNode.requestFocus();
  }

  String onErrorName() {
    return nameValidator ? "Este campo é obrigatório!" : null;
  }

  String onErrorComission() {
    return comissionValidator ? "Valor inválido!" : null;
  }

  final nameTextEditingController = TextEditingController();

  final comissionTextEditingController = TextEditingController();

  final focusNode = FocusNode();

  String editedDocumentId;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SnackBar getSnackBar({String message, SnackBarAction snackBarAction}) {
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Text(message),
      action: snackBarAction ?? null,
      backgroundColor: Colors.deepPurple,
    );
  }
}
