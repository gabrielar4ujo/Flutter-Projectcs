// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SalesPageController on _SalesPageControllerBase, Store {
  Computed<ObservableList<dynamic>> _$observableListComputed;

  @override
  ObservableList<dynamic> get observableList => (_$observableListComputed ??=
          Computed<ObservableList<dynamic>>(() => super.observableList,
              name: '_SalesPageControllerBase.observableList'))
      .value;
  Computed<String> _$yearComputed;

  @override
  String get year => (_$yearComputed ??= Computed<String>(() => super.year,
          name: '_SalesPageControllerBase.year'))
      .value;
  Computed<String> _$monthComputed;

  @override
  String get month => (_$monthComputed ??= Computed<String>(() => super.month,
          name: '_SalesPageControllerBase.month'))
      .value;

  final _$enabledFloatingActionButtonAtom =
      Atom(name: '_SalesPageControllerBase.enabledFloatingActionButton');

  @override
  bool get enabledFloatingActionButton {
    _$enabledFloatingActionButtonAtom.reportRead();
    return super.enabledFloatingActionButton;
  }

  @override
  set enabledFloatingActionButton(bool value) {
    _$enabledFloatingActionButtonAtom
        .reportWrite(value, super.enabledFloatingActionButton, () {
      super.enabledFloatingActionButton = value;
    });
  }

  final _$_observableListAtom =
      Atom(name: '_SalesPageControllerBase._observableList');

  @override
  ObservableList<dynamic> get _observableList {
    _$_observableListAtom.reportRead();
    return super._observableList;
  }

  @override
  set _observableList(ObservableList<dynamic> value) {
    _$_observableListAtom.reportWrite(value, super._observableList, () {
      super._observableList = value;
    });
  }

  final _$_yearAtom = Atom(name: '_SalesPageControllerBase._year');

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

  final _$_monthAtom = Atom(name: '_SalesPageControllerBase._month');

  @override
  String get _month {
    _$_monthAtom.reportRead();
    return super._month;
  }

  @override
  set _month(String value) {
    _$_monthAtom.reportWrite(value, super._month, () {
      super._month = value;
    });
  }

  final _$_SalesPageControllerBaseActionController =
      ActionController(name: '_SalesPageControllerBase');

  @override
  void setObservableList(List<dynamic> l) {
    final _$actionInfo = _$_SalesPageControllerBaseActionController.startAction(
        name: '_SalesPageControllerBase.setObservableList');
    try {
      return super.setObservableList(l);
    } finally {
      _$_SalesPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNullObservableList() {
    final _$actionInfo = _$_SalesPageControllerBaseActionController.startAction(
        name: '_SalesPageControllerBase.setNullObservableList');
    try {
      return super.setNullObservableList();
    } finally {
      _$_SalesPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setYear({String year}) {
    final _$actionInfo = _$_SalesPageControllerBaseActionController.startAction(
        name: '_SalesPageControllerBase.setYear');
    try {
      return super.setYear(year: year);
    } finally {
      _$_SalesPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMonth({String month}) {
    final _$actionInfo = _$_SalesPageControllerBaseActionController.startAction(
        name: '_SalesPageControllerBase.setMonth');
    try {
      return super.setMonth(month: month);
    } finally {
      _$_SalesPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enabledFloatingActionButton: ${enabledFloatingActionButton},
observableList: ${observableList},
year: ${year},
month: ${month}
    ''';
  }
}
