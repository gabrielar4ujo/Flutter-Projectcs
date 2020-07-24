// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on _ProductController, Store {
  Computed<bool> _$amountIsNotNullComputed;

  @override
  bool get amountIsNotNull =>
      (_$amountIsNotNullComputed ??= Computed<bool>(() => super.amountIsNotNull,
              name: '_ProductController.amountIsNotNull'))
          .value;

  final _$productNameAtom = Atom(name: '_ProductController.productName');

  @override
  String get productName {
    _$productNameAtom.reportRead();
    return super.productName;
  }

  @override
  set productName(String value) {
    _$productNameAtom.reportWrite(value, super.productName, () {
      super.productName = value;
    });
  }

  final _$sizeAtom = Atom(name: '_ProductController.size');

  @override
  String get size {
    _$sizeAtom.reportRead();
    return super.size;
  }

  @override
  set size(String value) {
    _$sizeAtom.reportWrite(value, super.size, () {
      super.size = value;
    });
  }

  final _$colorAtom = Atom(name: '_ProductController.color');

  @override
  String get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(String value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$amountAtom = Atom(name: '_ProductController.amount');

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

  final _$categoryNameAtom = Atom(name: '_ProductController.categoryName');

  @override
  String get categoryName {
    _$categoryNameAtom.reportRead();
    return super.categoryName;
  }

  @override
  set categoryName(String value) {
    _$categoryNameAtom.reportWrite(value, super.categoryName, () {
      super.categoryName = value;
    });
  }

  final _$_ProductControllerActionController =
      ActionController(name: '_ProductController');

  @override
  void changeProductSale(Product product) {
    final _$actionInfo = _$_ProductControllerActionController.startAction(
        name: '_ProductController.changeProductSale');
    try {
      return super.changeProductSale(product);
    } finally {
      _$_ProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productName: ${productName},
size: ${size},
color: ${color},
amount: ${amount},
categoryName: ${categoryName},
amountIsNotNull: ${amountIsNotNull}
    ''';
  }
}
