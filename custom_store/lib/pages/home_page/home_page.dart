import 'package:customstore/datas/product.dart';
import 'package:customstore/pages/home_page/home_page_controller.dart';
import 'package:customstore/pages/home_page/widgets/custom_box.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/login_page.dart';
import 'package:customstore/pages/stock_page/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinity_page_view/infinity_page_view.dart';
import 'package:mobx/mobx.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'widgets/custom_inkwell.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = HomePageController();

  String year = (DateTime.now().year).toString();
  final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();

  ReactionDisposer _disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposer = reaction((_) => controllerLoginPage.isLogged, (isLogged){
      if(!isLogged){
        print("logado");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  List<Widget> pages = List();
  List<String> list = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  @override
  Widget build(BuildContext context) {
    Product p = Product();
    p.price = 10.0;
    p.amount = 2;
    p.name = "Calçola";

    p.salesAmount = 2;
    p.vendedor = "iza";

    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;

    InfinityPageController infinityPageController =
        new InfinityPageController(initialPage: DateTime.now().month - 1);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Moda BA",
          style: GoogleFonts.openSansCondensed(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[ IconButton(iconSize: 25,icon: Icon(Icons.exit_to_app), onPressed: controllerLoginPage.logout,)],
      ),
      backgroundColor: Colors.deepPurple[500],
      body: Stack(
        children: <Widget>[
          /*Container(
            padding: EdgeInsets.only(top: 20),
            height: _screenHeight * .15,
            width: _screenHeight,
            child: Center(
              child: Text(
                "Moda BA",
                style: GoogleFonts.openSansCondensed(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),*/
          Container(
            height: _screenHeight,
            width: _screenWidth,
            child: Observer(
              builder: (context) {
                if (controllerLoginPage.isLoading)
                  return Container(
                      padding: EdgeInsets.only(top: 100),
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: CircularProgressIndicator()));

                pages = createWidgets();

                return InfinityPageView(
                    controller: infinityPageController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return pages[index];
                    });
              },
            ),
          ),
          SlidingSheet(
            duration: Duration(milliseconds: 400),
            controller: homePageController.sheetController,
            scrollSpec:
                const ScrollSpec(physics: NeverScrollableScrollPhysics()),
            //required
            elevation: 10,
            cornerRadius: 30,
            snapSpec: SnapSpec(
                snap: true,
                initialSnap: .4,
                snappings: [.2, .4],
                positioning: SnapPositioning.relativeToAvailableSpace),
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: _screenHeight * 0.38,
                child: Center(
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    //required
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    //Faz com que se possa centralizar o grid view
                    children: <Widget>[
                      CustomInkwell(
                        "Financeiro",
                        Icons.attach_money,
                        () {},
                      ),
                      CustomInkwell(
                        "Estoque",
                        Icons.shop,
                        () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => StockPage()));
                        },
                      ),
                      CustomInkwell(
                          "Adicionar Venda", Icons.shopping_cart, () {}),
                      CustomInkwell(
                        "Produto mais vendido",
                        Icons.star,
                        () {},
                      ),
                      CustomInkwell("Adicionar Vendedor", Icons.person, () {}),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> createWidgets() {
    return list.map((month) {
      final String index = (list.indexOf(month) + 1).toString();
      String saldo = "0.00";
      String lastPurchaseSalde = "0.00";

      /*if (model.dataMap.containsKey(year)) {
        saldo = model.dataMap[year][index] == null
            ? "0.00"
            : double.parse(model.dataMap[year][index].toString())
            .toStringAsFixed(2);
        lastPurchaseSalde = model.lastPurchaseMap[year][index] == null
            ? "0.00"
            : model.lastPurchaseMap[year][index].price.toStringAsFixed(2);
      }
*/
      print("oi");
      return Observer(
          builder: (context) => CustomBox(
                year: homePageController.year,
                month: month,
                obscure: homePageController.obscureSale,
                onTap: homePageController.changeObscureSaleState,
                lastPurchase: lastPurchaseSalde,
                sale: saldo,
                f: homePageController.expasionTile,
                isExpasion: homePageController.isExpasion,
            changeYear: homePageController.yearChanged,
              ));
    }).toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disposer();
  }
}
