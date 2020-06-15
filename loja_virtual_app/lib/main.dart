import 'package:flutter/material.dart';
import 'package:loja_virtual_app/models/cart_model.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:loja_virtual_app/screens/home_screen.dart';
import 'package:loja_virtual_app/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context,child,model) => ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Flutter's Clothing",
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 4, 125, 141)
              ),
              home: HomeScreen()
          ),
        ),
      )
    );
  }
}