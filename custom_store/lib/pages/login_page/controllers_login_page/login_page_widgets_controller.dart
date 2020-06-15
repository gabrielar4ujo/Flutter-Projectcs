import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'controller_login_page.dart';

part 'login_page_widgets_controller.g.dart';

class LoginPageWidgetsController = _LoginPageWidgetsController with _$LoginPageWidgetsController;

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

  String validatorEmail(){
    if(!isFormEmailValid && emailText.length > 0)  return "Email inválido!";
    return null;
  }

  String validatorPass(){
    if(!isFormPassValid && passText.length > 0)  return "Senha inválida!";
    return null;
  }

  @observable
  bool _obscure = true;

  @computed
  bool get obscure => _obscure;

  Function eyesClick(){
    changeObscure();
  }

  @action
  void changeObscure() => _obscure = !_obscure;

  @computed
  Function get loginPressed {
    return (isFormEmailValid && isFormPassValid)
        ? () {
      //print(emailText);
      controllerLoginPage.login(email: emailText, pass: passText);
    }
        : null;
  }

}