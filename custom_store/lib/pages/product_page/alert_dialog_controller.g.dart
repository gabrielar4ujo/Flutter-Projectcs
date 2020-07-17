// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_dialog_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlertDialogController on _AlertDialogController, Store {
  Computed<bool> _$enabledButtonComputed;

  @override
  bool get enabledButton =>
      (_$enabledButtonComputed ??= Computed<bool>(() => super.enabledButton,
              name: '_AlertDialogController.enabledButton'))
          .value;

  final _$colorNameAtom = Atom(name: '_AlertDialogController.colorName');

  @override
  String get colorName {
    _$colorNameAtom.reportRead();
    return super.colorName;
  }

  @override
  set colorName(String value) {
    _$colorNameAtom.reportWrite(value, super.colorName, () {
      super.colorName = value;
    });
  }

  final _$amountAtom = Atom(name: '_AlertDialogController.amount');

  @override
  String get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(String value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  final _$_AlertDialogControllerActionController =
      ActionController(name: '_AlertDialogController');

  @override
  void setColorName(String text) {
    final _$actionInfo = _$_AlertDialogControllerActionController.startAction(
        name: '_AlertDialogController.setColorName');
    try {
      return super.setColorName(text);
    } finally {
      _$_AlertDialogControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(String text) {
    final _$actionInfo = _$_AlertDialogControllerActionController.startAction(
        name: '_AlertDialogController.setAmount');
    try {
      return super.setAmount(text);
    } finally {
      _$_AlertDialogControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colorName: ${colorName},
amount: ${amount},
enabledButton: ${enabledButton}
    ''';
  }
}
