// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalize_product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FinalizeProductController on _FinalizeProductController, Store {
  Computed<int> _$countComputed;

  @override
  int get count => (_$countComputed ??= Computed<int>(() => super.count,
          name: '_FinalizeProductController.count'))
      .value;
  Computed<String> _$operationComputed;

  @override
  String get operation =>
      (_$operationComputed ??= Computed<String>(() => super.operation,
              name: '_FinalizeProductController.operation'))
          .value;

  final _$_countAtom = Atom(name: '_FinalizeProductController._count');

  @override
  int get _count {
    _$_countAtom.reportRead();
    return super._count;
  }

  @override
  set _count(int value) {
    _$_countAtom.reportWrite(value, super._count, () {
      super._count = value;
    });
  }

  final _$_operationAtom = Atom(name: '_FinalizeProductController._operation');

  @override
  String get _operation {
    _$_operationAtom.reportRead();
    return super._operation;
  }

  @override
  set _operation(String value) {
    _$_operationAtom.reportWrite(value, super._operation, () {
      super._operation = value;
    });
  }

  final _$_FinalizeProductControllerActionController =
      ActionController(name: '_FinalizeProductController');

  @override
  void increment() {
    final _$actionInfo = _$_FinalizeProductControllerActionController
        .startAction(name: '_FinalizeProductController.increment');
    try {
      return super.increment();
    } finally {
      _$_FinalizeProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOperetion(String operation) {
    final _$actionInfo = _$_FinalizeProductControllerActionController
        .startAction(name: '_FinalizeProductController.setOperetion');
    try {
      return super.setOperetion(operation);
    } finally {
      _$_FinalizeProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count},
operation: ${operation}
    ''';
  }
}
