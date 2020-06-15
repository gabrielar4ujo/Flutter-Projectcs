// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StockPageController on _StockPageController, Store {
  Computed<String> _$getPdComputed;

  @override
  String get getPd => (_$getPdComputed ??= Computed<String>(() => super.getPd,
          name: '_StockPageController.getPd'))
      .value;
  Computed<bool> _$productTextValidatorComputed;

  @override
  bool get productTextValidator => (_$productTextValidatorComputed ??=
          Computed<bool>(() => super.productTextValidator,
              name: '_StockPageController.productTextValidator'))
      .value;

  final _$productTextAtom = Atom(name: '_StockPageController.productText');

  @override
  String get productText {
    _$productTextAtom.reportRead();
    return super.productText;
  }

  @override
  set productText(String value) {
    _$productTextAtom.reportWrite(value, super.productText, () {
      super.productText = value;
    });
  }

  final _$_StockPageControllerActionController =
      ActionController(name: '_StockPageController');

  @override
  void setProductText(String s) {
    final _$actionInfo = _$_StockPageControllerActionController.startAction(
        name: '_StockPageController.setProductText');
    try {
      return super.setProductText(s);
    } finally {
      _$_StockPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productText: ${productText},
getPd: ${getPd},
productTextValidator: ${productTextValidator}
    ''';
  }
}
