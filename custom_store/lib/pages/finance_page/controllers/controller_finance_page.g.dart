// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_finance_page.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerFinancePage on _ControllerFinancePageBase, Store {
  Computed<String> _$yearComputed;

  @override
  String get year => (_$yearComputed ??= Computed<String>(() => super.year,
          name: '_ControllerFinancePageBase.year'))
      .value;

  final _$_yearAtom = Atom(name: '_ControllerFinancePageBase._year');

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

  final _$_ControllerFinancePageBaseActionController =
      ActionController(name: '_ControllerFinancePageBase');

  @override
  void setYear(String y) {
    final _$actionInfo = _$_ControllerFinancePageBaseActionController
        .startAction(name: '_ControllerFinancePageBase.setYear');
    try {
      return super.setYear(y);
    } finally {
      _$_ControllerFinancePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
year: ${year}
    ''';
  }
}
