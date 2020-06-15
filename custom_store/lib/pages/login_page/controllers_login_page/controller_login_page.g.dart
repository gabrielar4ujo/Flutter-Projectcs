// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_login_page.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerLoginPage on _ControllerLoginPage, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_ControllerLoginPage.isLoading'))
          .value;
  Computed<bool> _$isLoggedComputed;

  @override
  bool get isLogged =>
      (_$isLoggedComputed ??= Computed<bool>(() => super.isLogged,
              name: '_ControllerLoginPage.isLogged'))
          .value;

  final _$_isLoadingAtom = Atom(name: '_ControllerLoginPage._isLoading');

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  final _$userAtom = Atom(name: '_ControllerLoginPage.user');

  @override
  FirebaseUser get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$dataMapAtom = Atom(name: '_ControllerLoginPage.dataMap');

  @override
  ObservableMap<String, dynamic> get dataMap {
    _$dataMapAtom.reportRead();
    return super.dataMap;
  }

  @override
  set dataMap(ObservableMap<String, dynamic> value) {
    _$dataMapAtom.reportWrite(value, super.dataMap, () {
      super.dataMap = value;
    });
  }

  final _$salesMapAtom = Atom(name: '_ControllerLoginPage.salesMap');

  @override
  ObservableList<Map<dynamic, dynamic>> get salesMap {
    _$salesMapAtom.reportRead();
    return super.salesMap;
  }

  @override
  set salesMap(ObservableList<Map<dynamic, dynamic>> value) {
    _$salesMapAtom.reportWrite(value, super.salesMap, () {
      super.salesMap = value;
    });
  }

  final _$_isLoggedAtom = Atom(name: '_ControllerLoginPage._isLogged');

  @override
  bool get _isLogged {
    _$_isLoggedAtom.reportRead();
    return super._isLogged;
  }

  @override
  set _isLogged(bool value) {
    _$_isLoggedAtom.reportWrite(value, super._isLogged, () {
      super._isLogged = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_ControllerLoginPage.login');

  @override
  Future<Null> login({String email, String pass}) {
    return _$loginAsyncAction.run(() => super.login(email: email, pass: pass));
  }

  final _$_ControllerLoginPageActionController =
      ActionController(name: '_ControllerLoginPage');

  @override
  void logout() {
    final _$actionInfo = _$_ControllerLoginPageActionController.startAction(
        name: '_ControllerLoginPage.logout');
    try {
      return super.logout();
    } finally {
      _$_ControllerLoginPageActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
dataMap: ${dataMap},
salesMap: ${salesMap},
isLoading: ${isLoading},
isLogged: ${isLogged}
    ''';
  }
}
