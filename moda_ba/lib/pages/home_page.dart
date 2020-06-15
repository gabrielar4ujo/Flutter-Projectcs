import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinity_page_view/infinity_page_view.dart';
import 'package:moda_ba/models/financial_model.dart';
import 'package:moda_ba/pages/salesman_page.dart';
import 'package:moda_ba/widgets/button_box.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  String year = (DateTime.now().year).toString();
  bool iconEyes = false;
  List<Widget> pages = List();

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = MediaQuery.of(context).size.height;

    InfinityPageController infinityPageController =
        new InfinityPageController(initialPage: DateTime.now().month - 1);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.deepPurple[500],
          ),

          Container(
            padding: EdgeInsets.only(top: 20),
            height: _screenHeight * .15,
            width: _screenHeight,
            child:  Center(
              child: Text(
                "Moda BA",
                style: GoogleFonts.openSansCondensed(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),

          Positioned(
            top: _screenHeight * .1,
            height: _screenHeight * .40,
            left: 0,
            right: 0,
            child: ScopedModelDescendant<FinancialModel>(builder:
                (BuildContext context, Widget child, FinancialModel model) {
              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              pages = createWidgets(model);

              return InfinityPageView(
                  controller: infinityPageController,
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  });
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: _screenHeight * .40,
                color: Colors.transparent,
                child: Material(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 3,
                    children: <Widget>[
                      ButtonBox("Financeiro", Icons.attach_money, () {

                      },),

                      ButtonBox("Estoque", Icons.shop, () {

                      },),

                      ButtonBox("Adicionar Venda", Icons.shopping_cart, () {
                        setState(() {
                          year = (DateTime.now().year - 1).toString();
                        });
                      }),

                      ButtonBox("Produto mais vendido", Icons.star, () {

                      },),

                      ButtonBox( "Adicionar Vendedor", Icons.person, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SalesmanScreen()));
                      })
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  List<Widget> createWidgets(FinancialModel model) {
    return model.list.map((month) {
      final String index = (model.list.indexOf(month) + 1).toString();
      String saldo = "0.00";
      String lastPurchaseSalde = "00";

      if (model.dataMap.containsKey(year)) {
        saldo = model.dataMap[year][index] == null
            ? "0.00"
            : double.parse(model.dataMap[year][index].toString())
                .toStringAsFixed(2);
        lastPurchaseSalde = model.lastPurchaseMap[year][index] == null
            ? "0.00"
            : model.lastPurchaseMap[year][index].price.toStringAsFixed(2);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text("SALDO DE ${month.toUpperCase()}"),
              contentPadding: EdgeInsets.zero,
              trailing: Text(
                year,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  iconEyes = !iconEyes;
                });
                print(iconEyes);
              },
              contentPadding: EdgeInsets.zero,
              title: Text(
                iconEyes ? "R\$ $saldo" : "R\$ *******",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trailing: iconEyes
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Ultima venda feita no valor de R\$ $lastPurchaseSalde",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
      );
    }).toList();
  }
}
