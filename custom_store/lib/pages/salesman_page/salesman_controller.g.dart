// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salesman_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SalesmanController on _SalesmanController, Store {
  Computed<bool> _$nameValidatorComputed;

  @override
  bool get nameValidator =>
      (_$nameValidatorComputed ??= Computed<bool>(() => super.nameValidator,
              name: '_SalesmanController.nameValidator'))
          .value;
  Computed<bool> _$comissionValidatorComputed;

  @override
  bool get comissionValidator => (_$comissionValidatorComputed ??=
          Computed<bool>(() => super.comissionValidator,
              name: '_SalesmanController.comissionValidator'))
      .value;

  final _$isLoadingAtom = Atom(name: '_SalesmanController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isEditingAtom = Atom(name: '_SalesmanController.isEditing');

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  final _$nameTextAtom = Atom(name: '_SalesmanController.nameText');

  @override
  String get nameText {
    _$nameTextAtom.reportRead();
    return super.nameText;
  }

  @override
  set nameText(String value) {
    _$nameTextAtom.reportWrite(value, super.nameText, () {
      super.nameText = value;
    });
  }

  final _$comissionTextAtom = Atom(name: '_SalesmanController.comissionText');

  @override
  String get comissionText {
    _$comissionTextAtom.reportRead();
    return super.comissionText;
  }

  @override
  set comissionText(String value) {
    _$comissionTextAtom.reportWrite(value, super.comissionText, () {
      super.comissionText = value;
    });
  }

  final _$_SalesmanControllerActionController =
      ActionController(name: '_SalesmanController');

  @override
  void changeName(String text) {
    final _$actionInfo = _$_SalesmanControllerActionController.startAction(
        name: '_SalesmanController.changeName');
    try {
      return super.changeName(text);
    } finally {
      _$_SalesmanControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeComission(String text) {
    final _$actionInfo = _$_SalesmanControllerActionController.startAction(
        name: '_SalesmanController.changeComission');
    try {
      return super.changeComission(text);
    } finally {
      _$_SalesmanControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFields() {
    final _$actionInfo = _$_SalesmanControllerActionController.startAction(
        name: '_SalesmanController.resetFields');
    try {
      return super.resetFields();
    } finally {
      _$_SalesmanControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFields({String name, String comission, String documentID}) {
    final _$actionInfo = _$_SalesmanControllerActionController.startAction(
        name: '_SalesmanController.setFields');
    try {
      return super
          .setFields(name: name, comission: comission, documentID: documentID);
    } finally {
      _$_SalesmanControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isEditing: ${isEditing},
nameText: ${nameText},
comissionText: ${comissionText},
nameValidator: ${nameValidator},
comissionValidator: ${comissionValidator}
    ''';
  }
}
