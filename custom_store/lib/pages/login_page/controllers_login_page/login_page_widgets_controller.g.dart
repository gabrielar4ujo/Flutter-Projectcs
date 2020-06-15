// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_widgets_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageWidgetsController on _LoginPageWidgetsController, Store {
  Computed<bool> _$isFormEmailValidComputed;

  @override
  bool get isFormEmailValid => (_$isFormEmailValidComputed ??= Computed<bool>(
          () => super.isFormEmailValid,
          name: '_LoginPageWidgetsController.isFormEmailValid'))
      .value;
  Computed<bool> _$isFormPassValidComputed;

  @override
  bool get isFormPassValid =>
      (_$isFormPassValidComputed ??= Computed<bool>(() => super.isFormPassValid,
              name: '_LoginPageWidgetsController.isFormPassValid'))
          .value;
  Computed<bool> _$obscureComputed;

  @override
  bool get obscure => (_$obscureComputed ??= Computed<bool>(() => super.obscure,
          name: '_LoginPageWidgetsController.obscure'))
      .value;
  Computed<Function> _$loginPressedComputed;

  @override
  Function get loginPressed =>
      (_$loginPressedComputed ??= Computed<Function>(() => super.loginPressed,
              name: '_LoginPageWidgetsController.loginPressed'))
          .value;

  final _$emailTextAtom = Atom(name: '_LoginPageWidgetsController.emailText');

  @override
  String get emailText {
    _$emailTextAtom.reportRead();
    return super.emailText;
  }

  @override
  set emailText(String value) {
    _$emailTextAtom.reportWrite(value, super.emailText, () {
      super.emailText = value;
    });
  }

  final _$passTextAtom = Atom(name: '_LoginPageWidgetsController.passText');

  @override
  String get passText {
    _$passTextAtom.reportRead();
    return super.passText;
  }

  @override
  set passText(String value) {
    _$passTextAtom.reportWrite(value, super.passText, () {
      super.passText = value;
    });
  }

  final _$_obscureAtom = Atom(name: '_LoginPageWidgetsController._obscure');

  @override
  bool get _obscure {
    _$_obscureAtom.reportRead();
    return super._obscure;
  }

  @override
  set _obscure(bool value) {
    _$_obscureAtom.reportWrite(value, super._obscure, () {
      super._obscure = value;
    });
  }

  final _$_LoginPageWidgetsControllerActionController =
      ActionController(name: '_LoginPageWidgetsController');

  @override
  void setEmailText(String text) {
    final _$actionInfo = _$_LoginPageWidgetsControllerActionController
        .startAction(name: '_LoginPageWidgetsController.setEmailText');
    try {
      return super.setEmailText(text);
    } finally {
      _$_LoginPageWidgetsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassText(String text) {
    final _$actionInfo = _$_LoginPageWidgetsControllerActionController
        .startAction(name: '_LoginPageWidgetsController.setPassText');
    try {
      return super.setPassText(text);
    } finally {
      _$_LoginPageWidgetsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeObscure() {
    final _$actionInfo = _$_LoginPageWidgetsControllerActionController
        .startAction(name: '_LoginPageWidgetsController.changeObscure');
    try {
      return super.changeObscure();
    } finally {
      _$_LoginPageWidgetsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailText: ${emailText},
passText: ${passText},
isFormEmailValid: ${isFormEmailValid},
isFormPassValid: ${isFormPassValid},
obscure: ${obscure},
loginPressed: ${loginPressed}
    ''';
  }
}
