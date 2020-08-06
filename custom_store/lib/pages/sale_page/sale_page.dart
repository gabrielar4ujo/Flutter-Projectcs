import 'package:customstore/pages/add_sales_page/add_sales_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  ControllerLoginPage _controllerLoginPage;

  @override
  void initState() {
    super.initState();
    _controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    print(_controllerLoginPage.getCategorySnapshot());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as Vendas"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddSalesPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
