import 'package:flutter/material.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:loja_virtual_app/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
        appBar: AppBar(
          title: Text(
              "Entrar"
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute( //Ele sobrescreve a screen atual pela SingUpScreen, dái quando clicar na seta para voltar, não volta para essa screen
                    builder: (context) => SignUpScreen()
                ));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context,child,model){
            if(model.isLoading) return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _passController,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        onTap: (){
                          print("Esqueceu sua senha?");
                          if(_emailController.text.isEmpty) showSnackBar("Insire seu e-mail para recuperação",  Colors.redAccent);

                          else{
                            model.recoverPass(_emailController.text);
                            showSnackBar("Cheque seu e-mail",  Theme.of(context).primaryColor);
                          }
                        },
                        child: Text(
                            "Esqueceu sua senha?"
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          print("Sucesso");
                          model.signIn(email: _emailController.text, pass: _passController.text, onFail: _onFail, onSucess: _onSuccess);
                        }
                      },
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    showSnackBar("E-mail e/ou senha incorreto!",  Colors.redAccent);
  }

  void showSnackBar(String text, Color color){
    _scaffolKey.currentState.showSnackBar(
      SnackBar(content: Text(
        text,
      ),
        backgroundColor:color,
        duration: Duration(seconds: 2),
      ),
    );
  }
}


