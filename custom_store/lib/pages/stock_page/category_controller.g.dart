// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryController on _CategoryController, Store {
  final _$isLoadingAtom = Atom(name: '_CategoryController.isLoading');

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

  final _$isExpandedAtom = Atom(name: '_CategoryController.isExpanded');

  @override
  bool get isExpanded {
    _$isExpandedAtom.reportRead();
    return super.isExpanded;
  }

  @override
  set isExpanded(bool value) {
    _$isExpandedAtom.reportWrite(value, super.isExpanded, () {
      super.isExpanded = value;
    });
  }

  final _$_CategoryControllerActionController =
      ActionController(name: '_CategoryController');

  @override
  void onExpanded(bool b) {
    final _$actionInfo = _$_CategoryControllerActionController.startAction(
        name: '_CategoryController.onExpanded');
    try {
      return super.onExpanded(b);
    } finally {
      _$_CategoryControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isExpanded: ${isExpanded}
    ''';
  }
}
