import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'controller_login_page.dart';

part 'login_page_widgets_controller.g.dart';

class LoginPageWidgetsController = _LoginPageWidgetsController
    with _$LoginPageWidgetsController;

abstract class _LoginPageWidgetsController with Store {
  final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();

  @observable
  String emailText = '';

  @observable
  String passText = '';

  @computed
  bool get isFormEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(emailText);

  @computed
  bool get isFormPassValid => passText.length > 5;

  @action
  void setEmailText(String text) {
    emailText = text;
  }

  @action
  void setPassText(String text) => passText = text;

  String validatorEmail() {
    if (!isFormEmailValid && emailText.length > 0) return "Email inválido!";
    return null;
  }

  String validatorPass() {
    if (!isFormPassValid && passText.length > 0) return "Senha inválida!";
    return null;
  }

  @observable
  bool _obscure = true;

  @computed
  bool get obscure => _obscure;

  Function eyesClick() {
    changeObscure();
  }

  @action
  void changeObscure() => _obscure = !_obscure;

  @computed
  Function get loginPressed {
    return (isFormEmailValid && isFormPassValid)
        ? () async{
      bool r;
            await controllerLoginPage
                .login(email: emailText, pass: passText)
                .then((value) {
                  r = value is bool;
              if (!(r)) showSnackBar(value.code);
            });
            print("DEU CERTO O LOGIN: $r");
            return r;
          }
        : null;
  }

  void showSnackBar(String error) {
    print("LOGIN PAGE , SHOW SNACKBAR");
    print(error);
    String errorMessage;
    switch (error) {
      case "ERROR_INVALID_EMAIL":
        //errorMessage = "Your email address appears to be malformed.";
        errorMessage = "E-mail e/ou senha inválido!";
        break;
      case "ERROR_WRONG_PASSWORD":
        //errorMessage = "Your password is wrong.";
        errorMessage = "E-mail e/ou senha inválido!";
        break;
      case "ERROR_USER_NOT_FOUND":
        //errorMessage = "User with this email doesn't exist.";
        errorMessage = "Usuário não encontrado!";
        break;
      case "ERROR_USER_DISABLED":
        //errorMessage = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        //errorMessage = "Too many requests. Try again later.";
        errorMessage = "Muitos pedidos. Tente mais tarde!";
        break;
      case "ERROR_NETWORK_REQUEST_FAILED":
        errorMessage = "Problema de conexão!";
        break;
      default:
        errorMessage = "Ocorreu um erro indefinido!";
    }
    print(errorMessage);

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        errorMessage,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
      duration: Duration(seconds: 2),
    ));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}
