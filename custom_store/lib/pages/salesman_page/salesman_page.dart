import 'package:customstore/core/crud_salesman_controller.dart';
import 'package:customstore/pages/salesman_page/salesman_controller.dart';
import 'package:customstore/pages/salesman_page/widgets/add_salemans_widget.dart';
import 'package:customstore/pages/salesman_page/widgets/salesman_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SalesmanPage extends StatefulWidget {
  @override
  _SalesmanPageState createState() => _SalesmanPageState();
}

class _SalesmanPageState extends State<SalesmanPage> {
  CrudSalesmanController _crudSalesmanController;
  SalesmanController _salesmanController;

  @override
  void initState() {
    super.initState();
    _crudSalesmanController = CrudSalesmanController();
    _salesmanController = SalesmanController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _salesmanController.scaffoldKey,
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Vendedores"),
        actions: <Widget>[
          Observer(
            builder: (context) => IconButton(
              onPressed: _salesmanController.isEditing
                  ? () {
                      _salesmanController.isEditing = false;
                      _salesmanController.resetFields();
                    }
                  : () {},
              icon: Icon(
                  _salesmanController.isEditing ? Icons.clear : Icons.search),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          AddSalesmanWidget(
            crudSalesmanController: _crudSalesmanController,
            salesmanController: _salesmanController,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: SingleChildScrollView(
                      child: SalesmanContentWidget(
                        crudSalesmanController: _crudSalesmanController,
                        salesmanController: _salesmanController,
                      ),
                    )),
                Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.deepPurpleAccent,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _salesmanController.nameTextEditingController.dispose();
    _salesmanController.comissionTextEditingController.dispose();
    _salesmanController.focusNode.dispose();
  }
}
