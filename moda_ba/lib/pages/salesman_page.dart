import 'package:flutter/material.dart';
import 'package:moda_ba/helpers/products_helper.dart';
import 'package:moda_ba/helpers/salesman_helper.dart';
import 'package:moda_ba/models/financial_model.dart';

class SalesmanScreen extends StatelessWidget {

  SalesmanHelper salesmanHelper = SalesmanHelper();
  ProductHelper producthHelper = ProductHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Vendedor"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){


           /*   Salesman s = Salesman();
              s.name = "Airla";
              salesmanHelper.saveContact(s);
              salesmanHelper.getAllContacts().then((f){
                print(f);
              });
*/
              Product p = Product();
              p.price = 1;
              p.nameSalesman = "Iza";
              p.name = "Calcinha de renda";
              p.img = null;
              p.year = (DateTime.now().year ).toString();
              p.mounth = (DateTime.now().month).toString();
              p.day = (DateTime.now().day +1 ).toString() ;

              FinancialModel.of(context).save(p);
              //producthHelper.saveContact(p);
            /*  producthHelper.getAllContacts().then( (p) {
                print(p);
              })*/;

            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
