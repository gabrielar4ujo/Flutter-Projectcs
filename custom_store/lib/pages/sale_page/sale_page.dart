import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/pages/add_sales_page/add_sales_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/sale_page/controllers/sale_page_controller.dart';
import 'package:customstore/pages/sale_page/widgets/custom_page_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  int counter;
  ControllerLoginPage _controllerLoginPage;
  SalesPageController _salesPageController;

  @override
  void initState() {
    super.initState();
    _controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    _salesPageController = SalesPageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as Vendas"),
        centerTitle: false,
      ),
      floatingActionButton: Observer(builder: (_) {
        return FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: !_salesPageController.enabledFloatingActionButton
              ? null
              : () {
                  DocumentSnapshot d =
                      _salesPageController.getListToAddSalesPage();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddSalesPage(
                            listSales: d == null
                                ? []
                                : d.data[_salesPageController.month] ?? [],
                            documentID: d == null ? null : d.documentID,
                          )));
                },
          child: Icon(Icons.add),
        );
      }),
      body: StreamBuilder(
        stream: _controllerLoginPage.getSalesSnapshot(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            //Esse método faz com que a função passa como parâmetro só seja executada após a construção do widget
            if (snapshot == null || !snapshot.hasData)
              _salesPageController.enabledFloatingActionButton =
                  false; //Não permite que se adiciona alguma venda, enquanto dados básicos não foram carregados
            else
              _salesPageController.enabledFloatingActionButton = true;
          });

          if (snapshot == null || !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data != null && snapshot.data.documents.isEmpty) {
            _salesPageController.setObservableList(null);
            return (Center(
              child: Text("Não há vendas. Faça uma!"),
            ));
          } else {
            _salesPageController.setObservableList(snapshot.data.documents);

            return CustomPageViewWidget(
              salesPageController: _salesPageController,
              salesList: _salesPageController.observableList,
            );
          }
        },
      ),
    );
  }
}
