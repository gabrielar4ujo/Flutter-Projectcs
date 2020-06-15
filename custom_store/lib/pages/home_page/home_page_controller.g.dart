// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageController on _HomePageController, Store {
  Computed<String> _$yearComputed;

  @override
  String get year => (_$yearComputed ??=
          Computed<String>(() => super.year, name: '_HomePageController.year'))
      .value;
  Computed<bool> _$isExpasionComputed;

  @override
  bool get isExpasion =>
      (_$isExpasionComputed ??= Computed<bool>(() => super.isExpasion,
              name: '_HomePageController.isExpasion'))
          .value;
  Computed<bool> _$obscureSaleComputed;

  @override
  bool get obscureSale =>
      (_$obscureSaleComputed ??= Computed<bool>(() => super.obscureSale,
              name: '_HomePageController.obscureSale'))
          .value;

  final _$_yearAtom = Atom(name: '_HomePageController._year');

  @override
  String get _year {
    _$_yearAtom.reportRead();
    return super._year;
  }

  @override
  set _year(String value) {
    _$_yearAtom.reportWrite(value, super._year, () {
      super._year = value;
    });
  }

  final _$_isExpasionAtom = Atom(name: '_HomePageController._isExpasion');

  @override
  bool get _isExpasion {
    _$_isExpasionAtom.reportRead();
    return super._isExpasion;
  }

  @override
  set _isExpasion(bool value) {
    _$_isExpasionAtom.reportWrite(value, super._isExpasion, () {
      super._isExpasion = value;
    });
  }

  final _$_obscureSaleAtom = Atom(name: '_HomePageController._obscureSale');

  @override
  bool get _obscureSale {
    _$_obscureSaleAtom.reportRead();
    return super._obscureSale;
  }

  @override
  set _obscureSale(bool value) {
    _$_obscureSaleAtom.reportWrite(value, super._obscureSale, () {
      super._obscureSale = value;
    });
  }

  final _$_HomePageControllerActionController =
      ActionController(name: '_HomePageController');

  @override
  void yearChanged(String year) {
    final _$actionInfo = _$_HomePageControllerActionController.startAction(
        name: '_HomePageController.yearChanged');
    try {
      return super.yearChanged(year);
    } finally {
      _$_HomePageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void expasionTile(bool expasion) {
    final _$actionInfo = _$_HomePageControllerActionController.startAction(
        name: '_HomePageController.expasionTile');
    try {
      return super.expasionTile(expasion);
    } finally {
      _$_HomePageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeObscureSaleState() {
    final _$actionInfo = _$_HomePageControllerActionController.startAction(
        name: '_HomePageController.changeObscureSaleState');
    try {
      return super.changeObscureSaleState();
    } finally {
      _$_HomePageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
year: ${year},
isExpasion: ${isExpasion},
obscureSale: ${obscureSale}
    ''';
  }
}
