import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/crud_salesman_controller.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/salesman_page/salesman_controller.dart';
import 'package:customstore/pages/salesman_page/tiles/salesman_content_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SalesmanContentWidget extends StatefulWidget {

  final CrudSalesmanController crudSalesmanController;
  final SalesmanController salesmanController;

  const SalesmanContentWidget({Key key,@required this.crudSalesmanController, this.salesmanController}) : super(key: key);

  @override
  _SalesmanContentWidgetState createState() => _SalesmanContentWidgetState();
}

class _SalesmanContentWidgetState extends State<SalesmanContentWidget> {
  ControllerLoginPage _controllerLoginPage;

  @override
  void initState() {
    super.initState();
    _controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controllerLoginPage.getSalesmanListSnapshot(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return customCenter(Center(child: CircularProgressIndicator()));

        else if (snapshot.data.documents == null ||
            snapshot.data.documents.length == 0)
          return customCenter(
            Center(
              child: Text(
                "Adicione um vendedor!",
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
              ),
            ),
          );
        print("Salesman Adicionado");

        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot salesmanSnapshot =
                  snapshot.data.documents[index];
              print(salesmanSnapshot.data["name"]);
              return SalesmanContentTile(crudSalesmanController: widget.crudSalesmanController,salesmanController: widget.salesmanController,
                  salesmanSnapshot: snapshot.data.documents[index]);
            });
      },
    );
  }

  Container customCenter (Widget widget){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: widget
    );
  }
}
