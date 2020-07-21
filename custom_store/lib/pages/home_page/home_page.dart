import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:customstore/pages/home_page/home_page_controller.dart';
import 'package:customstore/pages/home_page/widgets/custom_box.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/login_page.dart';
import 'package:customstore/pages/salesman_page/salesman_page.dart';
import 'package:customstore/pages/stock_page/stock_page.dart';
import 'package:customstore/utils/global_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinity_page_view/infinity_page_view.dart';
import 'package:mobx/mobx.dart';

import 'widgets/custom_inkwell.dart';
import 'widgets/fade_container.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  HomePageController homePageController;

  GlobalScaffold globalScaffold;

  String year = (DateTime.now().year).toString();
  ControllerLoginPage controllerLoginPage;
  ReactionDisposer _disposer;

  bool statusConnection = false;
  String connetionStatus = "Unknown";
  Connectivity conectivity;
  StreamSubscription<ConnectivityResult> subscription;

  Animation<double> fadeAnimation;
  AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    globalScaffold = GetIt.I.get<GlobalScaffold>();
    homePageController = HomePageController();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    fadeAnimation = Tween<double>(
        begin: 1.0,end: 0.0
    ).animate(CurvedAnimation(
        curve: Curves.easeInQuint,
        parent: _animationController
    ));

    _animationController.forward();

    conectivity = Connectivity();
    subscription = conectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      bool hasConnection;
      try {
        await Firestore.instance
            .runTransaction((Transaction tx) {})
            .timeout(Duration(seconds: 5));
        hasConnection = true;
      } on PlatformException catch (_) {
        // May be thrown on Airplane mode
        hasConnection = false;
      } on TimeoutException catch (_) {
        hasConnection = false;
      }
      String message =
          hasConnection ? "Você está conectado!" : "Problema de conexão!";
      if (statusConnection || !hasConnection) {
        statusConnection = true;
        globalScaffold.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposer = reaction((_) => controllerLoginPage.isLogged, (isLogged) {
      if (!isLogged) {
        print("logado");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
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

  Widget _buildAnimation(BuildContext context, Widget child){

    InfinityPageController infinityPageController =
    new InfinityPageController(initialPage: DateTime.now().month - 1);

    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
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
            padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
            child:      IconButton(
              color: Colors.white,
              iconSize: 25,
              padding: EdgeInsets.only(right: 10),
              icon: Icon(Icons.exit_to_app),
              onPressed: controllerLoginPage.logout,
            )
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 50 + MediaQuery.of(context).padding.top),
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
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Container(
            //padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            height: _screenWidth * .285 ,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                CustomInkwell(
                  "Financeiro",
                  Icons.attach_money,
                      () {},
                ),
                CustomInkwell(
                    "Adicionar Venda", Icons.shopping_cart, () {}),
                CustomInkwell(
                  "Estoque",
                  Icons.shop,
                      () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StockPage()));
                  },
                ),
                CustomInkwell(
                  "Produto mais vendido",
                  Icons.star,
                      () {},
                ),
                CustomInkwell("Adicionar Vendedor", Icons.person, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SalesmanPage()));
                }),
              ],
            ),
          ),
        ),
        FadeContainer(
          fadeAnimation: fadeAnimation,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
     /* appBar: AppBar(
        elevation: 0,
        title: Text(
          "Moda BA",
          style: GoogleFonts.openSansCondensed(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            iconSize: 25,
            padding: EdgeInsets.only(right: 10),
            icon: Icon(Icons.exit_to_app),
            onPressed: controllerLoginPage.logout,
          )
        ],
      ),*/
      backgroundColor: Colors.deepPurple[500],
      body: Container(
        child: AnimatedBuilder(
          builder: _buildAnimation, animation: _animationController,
        ),
      )
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
                isExpasion: homePageController.isExpasion,
                changeYear: homePageController.yearChanged,
              ));
    }).toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
    _disposer();
    subscription.cancel();
    _animationController.dispose();
  }
}
