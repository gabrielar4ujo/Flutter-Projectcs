import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/models/ordinal_sales.dart';
import 'package:mobx/mobx.dart';
part 'controller_finance_page.g.dart';

class ControllerFinancePage = _ControllerFinancePageBase
    with _$ControllerFinancePage;

abstract class _ControllerFinancePageBase with Store {
  _ControllerFinancePageBase();

  Map<String, List<OrdinalSales>> salesMap = Map();
  List ordinalSalesList;
  List allYears = List();

  OrdinalSales more = OrdinalSales("Vazio", 0);
  OrdinalSales less = OrdinalSales("Vazio", null);
  double lucre = 0;
  double media = 0;

  void setOrdinalSalesList(l) {
    ordinalSalesList = l;
    setData();
  }

  void resetData() {
    more = OrdinalSales("Vazio", null);
    less = OrdinalSales("Vazio", null);

    lucre = 0;

    media = 0;
  }

  void setData() {
    for (OrdinalSales ordinalSales in ordinalSalesList) {
      if (more.sales == null || ordinalSales.sales > more.sales) {
        more = ordinalSales;
      }
      if (less.sales == null || less.sales > ordinalSales.sales) {
        less = ordinalSales;
      }
      lucre += ordinalSales.sales;
    }

    media = lucre / 12;
  }

  List<OrdinalSales> getListOrdinalSales() {
    resetData();
    if (salesMap.isEmpty) return List();
    return salesMap.containsKey(_year) ? salesMap[_year] : List();
  }

  void createMapWithSales(List<DocumentSnapshot> list) {
    for (DocumentSnapshot document in list) {
      Map m = document.data;
      String date = m["time"].toDate().year.toString();
      m.remove("time");
      salesMap[date] = [];
      m.forEach((key, value) {
        salesMap[date].add(OrdinalSales(
            Calendary().getMonth(key).substring(0, 3).toUpperCase(),
            calcule(value)));
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
  }

  @observable
  String _year = DateTime.now().year.toString();

  @computed
  String get year => _year;

  @action
  void setYear(String y) {
    _year = y ?? DateTime.now().year.toString();
  }

  double calcule(List sales) {
    double value = 0;
    for (Map m in sales) {
      m["productList"].forEach((e) {
        value += (double.parse(e["price"]) * int.parse(e["selectedAmount"]));
      });
    }

    return value;
  }
}
