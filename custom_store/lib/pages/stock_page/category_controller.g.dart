// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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

  final _$observableMapAtom = Atom(name: '_CategoryController.observableMap');

  @override
  ObservableList<Product> get observableMap {
    _$observableMapAtom.reportRead();
    return super.observableMap;
  }

  @override
  set observableMap(ObservableList<Product> value) {
    _$observableMapAtom.reportWrite(value, super.observableMap, () {
      super.observableMap = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
observableMap: ${observableMap}
    ''';
  }
}
