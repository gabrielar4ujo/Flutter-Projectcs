// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleman_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SalemanController on _SalemanController, Store {
  final _$salesmanNameAtom = Atom(name: '_SalemanController.salesmanName');

  @override
  String get salesmanName {
    _$salesmanNameAtom.reportRead();
    return super.salesmanName;
  }

  @override
  set salesmanName(String value) {
    _$salesmanNameAtom.reportWrite(value, super.salesmanName, () {
      super.salesmanName = value;
    });
  }

  final _$salesmanComissionAtom =
      Atom(name: '_SalemanController.salesmanComission');

  @override
  double get salesmanComission {
    _$salesmanComissionAtom.reportRead();
    return super.salesmanComission;
  }

  @override
  set salesmanComission(double value) {
    _$salesmanComissionAtom.reportWrite(value, super.salesmanComission, () {
      super.salesmanComission = value;
    });
  }

  final _$_SalemanControllerActionController =
      ActionController(name: '_SalemanController');

  @override
  void setSalesman(Salesman s) {
    final _$actionInfo = _$_SalemanControllerActionController.startAction(
        name: '_SalemanController.setSalesman');
    try {
      return super.setSalesman(s);
    } finally {
      _$_SalemanControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
salesmanName: ${salesmanName},
salesmanComission: ${salesmanComission}
    ''';
  }
}
