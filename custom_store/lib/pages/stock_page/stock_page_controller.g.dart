// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StockPageController on _StockPageController, Store {
  Computed<bool> _$wasEditedComputed;

  @override
  bool get wasEdited =>
      (_$wasEditedComputed ??= Computed<bool>(() => super.wasEdited,
              name: '_StockPageController.wasEdited'))
          .value;
  Computed<String> _$productTextComputed;

  @override
  String get productText =>
      (_$productTextComputed ??= Computed<String>(() => super.productText,
              name: '_StockPageController.productText'))
          .value;
  Computed<bool> _$productTextValidatorComputed;

  @override
  bool get productTextValidator => (_$productTextValidatorComputed ??=
          Computed<bool>(() => super.productTextValidator,
              name: '_StockPageController.productTextValidator'))
      .value;

  final _$_wasEditedAtom = Atom(name: '_StockPageController._wasEdited');

  @override
  bool get _wasEdited {
    _$_wasEditedAtom.reportRead();
    return super._wasEdited;
  }

  @override
  set _wasEdited(bool value) {
    _$_wasEditedAtom.reportWrite(value, super._wasEdited, () {
      super._wasEdited = value;
    });
  }

  final _$_productTextAtom = Atom(name: '_StockPageController._productText');

  @override
  String get _productText {
    _$_productTextAtom.reportRead();
    return super._productText;
  }

  @override
  set _productText(String value) {
    _$_productTextAtom.reportWrite(value, super._productText, () {
      super._productText = value;
    });
  }

  final _$_StockPageControllerActionController =
      ActionController(name: '_StockPageController');

  @override
  void changeWasEdited(String lastName) {
    final _$actionInfo = _$_StockPageControllerActionController.startAction(
        name: '_StockPageController.changeWasEdited');
    try {
      return super.changeWasEdited(lastName);
    } finally {
      _$_StockPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProductText(String currentName, String lastName) {
    final _$actionInfo = _$_StockPageControllerActionController.startAction(
        name: '_StockPageController.setProductText');
    try {
      return super.setProductText(currentName, lastName);
    } finally {
      _$_StockPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
wasEdited: ${wasEdited},
productText: ${productText},
productTextValidator: ${productTextValidator}
    ''';
  }
}
