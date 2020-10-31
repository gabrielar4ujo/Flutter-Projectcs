import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:customstore/core/calendary.dart';
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

  ControllerLoginPage controllerLoginPage;
  bool statusConnection = false;

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

              pages = createWidgets(
                  homePageController.salesMap[homePageController.year]);

              return InfinityPageView(
                  controller: infinityPageController,
                  itemCount: Calendary().calendaryList.length,
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
                    CustomInkwell("Adicionar Venda", Icons.shopping_cart,
                        () async {
                      homePageController.cancelStreamSubscription();
                      await Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => SalesPage()))
                          .whenComplete(() =>
                              homePageController.initStreamSubscription());
                    }),
                    CustomInkwell(
                      "Estoque",
                      Icons.shop,
                      () {
                        homePageController.cancelStreamSubscription();
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

  List<Widget> createWidgets(final listMap) {
    return Calendary().calendaryList.map((month) {
      int indexMonth = -1;
      String saldo = "0.00";
      String lastPurchaseSalde = "0.00";
      if (listMap != null) {
        indexMonth = listMap.indexOf(OrdinalSales(month, null));

        saldo = indexMonth != -1
            ? listMap[indexMonth].sales.toStringAsFixed(2)
            : "0.00";
        lastPurchaseSalde = indexMonth != -1
            ? listMap[indexMonth].lastProductPurchase.price.toStringAsFixed(2)
            : "0.00";
      }

      return Observer(
          builder: (context) => CustomBox(
                year: homePageController.year,
                clientName: indexMonth != -1
                    ? listMap[indexMonth].lastProductPurchase.clientName
                    : "Não há",
                productName: indexMonth != -1
                    ? listMap[indexMonth].lastProductPurchase.name
                    : "Não há",
                productValue: indexMonth != -1
                    ? listMap[indexMonth]
                        .lastProductPurchase
                        .spent
                        .toStringAsFixed(2)
                    : "Não há",
                salesmanName: indexMonth != -1
                    ? listMap[indexMonth].lastProductPurchase.categoryId
                    : "Não há",
                month: month,
                obscure: homePageController.obscureSale,
                onTap: homePageController.changeObscureSaleState,
                lastPurchase: lastPurchaseSalde,
                sale: saldo,
                isExpasion: homePageController.isExpasion,
                changeYear: homePageController.yearChanged,
                allYears: homePageController.allYears,
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
