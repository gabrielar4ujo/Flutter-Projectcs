import 'package:customstore/pages/home_page/home_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/login_page_widgets_controller.dart';
import 'package:customstore/pages/login_page/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
  final _widgetsController = LoginPageWidgetsController();

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    disposer = reaction(
            (_) => controllerLoginPage.isLogged,
            (loggedIn){
          if(loggedIn)
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _widgetsController.scaffoldKey,
      backgroundColor: Colors.deepPurpleAccent,
      body: Container(
        padding: EdgeInsets.only(top: 35),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Icons.store, size: 200,color: Colors.white,),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[

                      Observer(builder: (context) => CustomTextFieldWidget(labelText: "Email", function: _widgetsController.setEmailText, error: _widgetsController.validatorEmail(),enabled: !controllerLoginPage.isLoading,)),
                      SizedBox(height: 10,),
                      Observer(builder: (context) => CustomTextFieldWidget(labelText: "Senha", function: _widgetsController.setPassText, error: _widgetsController.validatorPass(),obscure: _widgetsController.obscure, eyeFunction: _widgetsController.changeObscure,enabled: !controllerLoginPage.isLoading,)),
                      SizedBox(height: 10,),

                      Observer(
                        builder: (context) => RaisedButton(
                          color: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          onPressed: _widgetsController.loginPressed,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: controllerLoginPage.isLoading ? Container(
                            height: 23,
                            width: 23,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ) : Text("Entrar", style: TextStyle(fontSize: 20, color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposer();
  }
}
