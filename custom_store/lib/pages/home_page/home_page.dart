import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:customstore/models/ordinal_sales.dart';
import 'package:customstore/pages/best_selling_product_page/best_selling_product_page.dart';
import 'package:customstore/pages/finance_page/finance_page.dart';
import 'package:customstore/pages/home_page/home_page_controller.dart';
import 'package:customstore/pages/home_page/widgets/custom_box.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/login_page.dart';
import 'package:customstore/pages/sale_page/sale_page.dart';
import 'package:customstore/pages/salesman_page/salesman_page.dart';
import 'package:customstore/pages/stock_page/stock_page.dart';
import 'package:customstore/utils/global_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

import 'widgets/custom_inkwell.dart';
import 'widgets/fade_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePageController homePageController;

  GlobalScaffold globalScaffold;

  bool animationFinish = false;
  String year = (DateTime.now().year).toString();
  ControllerLoginPage controllerLoginPage;
  bool statusConnection = false;
  String connetionStatus = "Unknown";
  Connectivity conectivity;
  StreamSubscription<ConnectivityResult> subscription;

  Animation<double> fadeAnimation;
  Animation<double> paddingAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    globalScaffold = GetIt.I.get<GlobalScaffold>();
    homePageController = HomePageController(controllerLoginPage);

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3500));

    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.0, 0.45, curve: Curves.easeInQuint),
        parent: _animationController));

    paddingAnimation = Tween<double>(begin: 250, end: 0.0).animate(
        CurvedAnimation(
            curve: Interval(0.40, 1.0, curve: Curves.elasticOut),
            parent: _animationController));

    _animationController.forward().whenCompleteOrCancel(() {
      animationFinish = true;
      controllerLoginPage.loadCurrentUser();
      homePageController.initStreamSubscription();
    });

    conectivity = Connectivity();
    subscription =
        conectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      bool hasConnection = ConnectivityResult.mobile == result ||
          ConnectivityResult.wifi == result;

      String message = hasConnection
          ? "Você está conectado a uma rede!"
          : "Você não está conectado!";
      if (statusConnection || !hasConnection) {
        controllerLoginPage.timeOut = hasConnection ? 5 : 1;
        statusConnection = true;
        globalScaffold.showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.black,
        ));
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

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
            child: Text(
              "Moda BA",
              style: GoogleFonts.openSansCondensed(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
              child: Observer(builder: (_) {
                return IconButton(
                  disabledColor: Colors.white,
                  color: Colors.white,
                  iconSize: 25,
                  padding: EdgeInsets.only(right: 10),
                  icon: Icon(Icons.exit_to_app),
                  onPressed: controllerLoginPage.isLoading || !animationFinish
                      ? null
                      : () {
                          controllerLoginPage.logout();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                );
              })),
        ),
        Container(
          margin: EdgeInsets.only(top: 50 + MediaQuery.of(context).padding.top),
          height: _screenHeight,
          width: _screenWidth,
          child: Observer(
            builder: (context) {
              if (controllerLoginPage.isLoading ||
                  !(_animationController.status == AnimationStatus.completed))
                return CustomBox();

              pages = createWidgets(homePageController.salesMap);
              print("recontrstruido");

              return InfinityPageView(
                  controller: infinityPageController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  });
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: paddingAnimation.value,
          right: 0,
          child: Observer(builder: (_) {
            return IgnorePointer(
              ignoring: !(!controllerLoginPage.isLoading &&
                  _animationController.status == AnimationStatus.completed),
              child: Container(
                height: _screenWidth * .285,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CustomInkwell(
                      "Financeiro",
                      Icons.attach_money,
                      () {
                        homePageController.cancelStreamSubscription();
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => FinancePage()))
                            .whenComplete(() =>
                                homePageController.initStreamSubscription());
                      },
                    ),
                    CustomInkwell("Adicionar Venda", Icons.shopping_cart, () {
                      homePageController.cancelStreamSubscription();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SalesPage()));
                    }),
                    CustomInkwell(
                      "Estoque",
                      Icons.shop,
                      () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => StockPage()))
                            .whenComplete(() =>
                                homePageController.initStreamSubscription());
                      },
                    ),
                    CustomInkwell("Adicionar Vendedor", Icons.person, () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SalesmanPage()));
                    }),
                    CustomInkwell(
                      "Produto mais vendido",
                      Icons.star,
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BestSellingProductPage()));
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        FadeContainer(
          fadeAnimation: fadeAnimation,
        )
      ],
    );
  }

  double _screenHeight;
  double _screenWidth;
  InfinityPageController infinityPageController;
  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    infinityPageController =
        InfinityPageController(initialPage: DateTime.now().month - 1);

    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.deepPurple[500],
        body: Container(
          child: AnimatedBuilder(
            builder: _buildAnimation,
            animation: _animationController,
          ),
        ));
  }

  List<Widget> createWidgets(final salesMap) {
    print(salesMap["2020"].contains(OrdinalSales("Outubro", null)));
    return list.map((month) {
      //final String index = (list.indexOf(month) + 1).toString();
      int indexMonth = salesMap[year].indexOf(OrdinalSales(month, null));

      String saldo = indexMonth != -1
          ? salesMap[year][indexMonth].sales.toStringAsFixed(2)
          : "0.00";
      String lastPurchaseSalde = indexMonth != -1
          ? salesMap[year][indexMonth]
              .lastProductPurchase
              .price
              .toStringAsFixed(2)
          : "0.00";
      print("lastrPurchase $lastPurchaseSalde");
      return Observer(
          builder: (context) => CustomBox(
                year: homePageController.year,
                clientName: indexMonth != -1
                    ? salesMap[year][indexMonth].lastProductPurchase.clientName
                    : "Não há",
                productName: indexMonth != -1
                    ? salesMap[year][indexMonth].lastProductPurchase.name
                    : "Não há",
                productValue: indexMonth != -1
                    ? salesMap[year][indexMonth]
                        .lastProductPurchase
                        .spent
                        .toStringAsFixed(2)
                    : "Não há",
                salesmanName: indexMonth != -1
                    ? salesMap[year][indexMonth].lastProductPurchase.categoryId
                    : "Não há",
                month: month,
                obscure: homePageController.obscureSale,
                onTap: homePageController.changeObscureSaleState,
                lastPurchase: lastPurchaseSalde,
                sale: saldo,
                isExpasion: homePageController.isExpasion,
                changeYear: homePageController.yearChanged,
              ));
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
    _animationController.dispose();
  }
}
