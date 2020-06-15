import 'package:customstore/datas/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductPage extends StatelessWidget {

/*  final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();*/

  final Product product;

  ProductPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela do Produto"),
      ),
      body: Container(
        color: Colors.black
      )
    );
  }
}
