import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/pages/finance_page/widgets/horizontal_bar_chat.dart';
import 'package:mobx/mobx.dart';
part 'controller_finance_page.g.dart';

class ControllerFinancePage = _ControllerFinancePageBase
    with _$ControllerFinancePage;

abstract class _ControllerFinancePageBase with Store {
  _ControllerFinancePageBase();

  Map salesMap = Map();

  List<OrdinalSales> getListOrdinalSales() {
    if (salesMap.isEmpty) return List();
    return salesMap.containsKey(_year) ? [salesMap[_year]] : List();
  }

  void createMapWithSales(List<DocumentSnapshot> list) {
    //print(list.first.data["10"].first);
    for (DocumentSnapshot document in list) {
      Map m = document.data;
      String date = m["time"].toDate().year.toString();
      m.remove("time");
      m.forEach((key, value) {
        print(key);
        //print(value is List);

        salesMap[date] = OrdinalSales(
            Calendary().getMonth(key).substring(0, 3).toUpperCase(),
            calcule(value));
      });
      //salesMap[m["time"].toDate().year] = OrdinalSales(year, sales);
    }
    print(salesMap);
  }

  @observable
  String _year = DateTime.now().year.toString();

  @computed
  String get year => _year;

  @action
  void setYear(String y) {
    _year = y ?? DateTime.now().year.toString();
    print(year);
  }

  double calcule(List sales) {
    double value = 0;
    for (Map m in sales) {
      //print(m);
      m["productList"].forEach((e) {
        print(e);
        value += (double.parse(e["price"]) * int.parse(e["selectedAmount"]));
      });
    }

    //print(value);
    return value;
  }
}
