import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/models/ordinal_sales.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:mobx/mobx.dart';

part 'home_page_controller.g.dart';

class HomePageController = _HomePageController with _$HomePageController;

abstract class _HomePageController with Store {
  final ControllerLoginPage _controllerLoginPage;

  StreamSubscription streamSubscription;

  @observable
  String _year = DateTime.now().year.toString();

  _HomePageController(this._controllerLoginPage);

  @computed
  String get year => _year;

  @action
  void yearChanged(String year) {
    _year = year;
  }

  @observable
  bool _isExpasion = false;

  @computed
  bool get isExpasion => _isExpasion;

  @observable
  bool _obscureSale = true;

  @computed
  bool get obscureSale => _obscureSale;

  @action
  void changeObscureSaleState() => _obscureSale = !_obscureSale;

  @observable
  ObservableMap<String, List<OrdinalSales>> salesMap = ObservableMap();

  List allYears;

  void createMapWithSales(List<DocumentSnapshot> list) {
    for (DocumentSnapshot document in list) {
      Map m = document.data;
      String date = m["time"].toDate().year.toString();
      m.remove("time");
      salesMap[date] = [];
      m.forEach((key, value) {
        Map productMap = value.last;
        //Map productMap = value.last["productList"].last;
        print("producctMao $productMap");
        salesMap[date].add(OrdinalSales(
            Calendary().getMonth(key), calcule(value),
            lastProductPurchase: Product(
                name: productMap["productList"].last["productName"],
                spent: double.parse(productMap["productList"].last["price"]),
                price: calculeLastPurchase(productMap["productList"]))
              ..selectedAmount = productMap["selectedAmount"]
              ..clientName = productMap["clientName"]
              ..categoryId = productMap["salesmanName"]));
        // print("value: $value");
        // print(value[0]);
      });
    }
    // salesMap["2019"] = [];
    // salesMap["2019"].add(OrdinalSales("JAN", 10000));
    // salesMap["2019"].add(OrdinalSales("MAR", 200));
    // salesMap["2019"].add(OrdinalSales("JUN", 6000));

    // salesMap["2018"] = [];
    // salesMap["2018"].add(OrdinalSales("JAN", 10000));
    // salesMap["2018"].add(OrdinalSales("MAR", 200));
    // salesMap["2018"].add(OrdinalSales("JUN", 6000));

    // salesMap["2017"] = [];
    // salesMap["2017"].add(OrdinalSales("JAN", 10000));
    // salesMap["2017"].add(OrdinalSales("MAR", 200));
    // salesMap["2017"].add(OrdinalSales("JUN", 6000));

    // salesMap["2016"] = [];
    // salesMap["2016"].add(OrdinalSales("JAN", 10000));
    // salesMap["2016"].add(OrdinalSales("MAR", 200));
    // salesMap["2016"].add(OrdinalSales("JUN", 6000));

    allYears = salesMap.keys.toList();
    allYears.sort();
    print(salesMap);
  }

  double calcule(List sales) {
    double value = 0;
    print("sales ${sales.last}");
    for (Map m in sales) {
      m["productList"].forEach((e) {
        value += (double.parse(e["price"]) * int.parse(e["selectedAmount"]));
      });
      //print("last ${m["productList"].last}");
    }

    return value;
  }

  double calculeLastPurchase(List l) {
    double finalValue = 0.00;

    for (Map m in l) {
      finalValue += (double.parse(m["price"]) * int.parse(m["selectedAmount"]));
    }

    return finalValue;
  }

  void initStreamSubscription() {
    streamSubscription =
        _controllerLoginPage.getSalesSnapshot().listen((event) {
      createMapWithSales(event.documents);
    });
  }

  void cancelStreamSubscription() {
    streamSubscription.cancel();
  }
}
