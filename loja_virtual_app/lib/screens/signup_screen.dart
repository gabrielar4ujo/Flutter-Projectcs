import 'package:flutter/material.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _adressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
        appBar: AppBar(
          title: Text(
              "Criar Conta"
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context,child,model){
            if (model.isLoading) return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    validator: (text){
                      if(text.isEmpty) return "Nome inválido";
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "Nome Completo"
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "E-mail inválido";
                      return null;
                    },
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
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _adressController,
                    validator: (text){
                      if(text.isEmpty) return "Endereço inválido";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Endereço"
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String,dynamic> userData = {
                            "name" : _nameController.text,
                            "email" : _emailController.text,
                            "adress" : _adressController.text
                          };

                          print("Sucesso");
                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSucess: _onSuccess,
                              onFail: _onFail);
                        }
                        else print("Falha");
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
    _scaffolKey.currentState.showSnackBar(
      SnackBar(content: Text(
        "Usuário criado com sucesso!",
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffolKey.currentState.showSnackBar(
      SnackBar(content: Text(
        "Falha ao criar usuário!",
      ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

}
