import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/pages/finance_page/controllers/controller_finance_page.dart';
import 'package:customstore/models/ordinal_sales.dart';
import 'package:customstore/pages/finance_page/widgets/content_page_view_widget.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

class FinancePage extends StatefulWidget {
  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  ControllerFinancePage _controllerFinancePage = ControllerFinancePage();
  List<Widget> widgetsList = List();

  InfinityPageController _infinityPageController;

  List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<OrdinalSales> listData) {
    bool containsInListData = false;

    for (int monthIndex = 1; monthIndex <= 12; monthIndex++) {
      containsInListData = listData.contains(OrdinalSales(
          Calendary()
              .getMonth(monthIndex.toString())
              .substring(0, 3)
              .toUpperCase(),
          null));
      if (!containsInListData)
        listData.add(OrdinalSales(
            "${Calendary().getMonth(monthIndex.toString()).substring(0, 3).toUpperCase()}",
            0));
    }

    listData.sort();
    _controllerFinancePage.setOrdinalSalesList(listData);

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
        domainFn: (OrdinalSales sales, _) => sales.month,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        labelAccessorFn: (OrdinalSales sales, _) =>
            sales.sales == 0 ? null : "R\$: ${sales.sales.toStringAsFixed(2)}",
        data: listData,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financeiro"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: GetIt.I.get<ControllerLoginPage>().getSalesSnapshot(),
          builder: (context, snapshot) {
            List<charts.Series<dynamic, String>> series =
                _createSampleData(List());
            if (snapshot.hasData) {
              _controllerFinancePage
                  .createMapWithSales(snapshot.data.documents);
              series = _createSampleData(
                  _controllerFinancePage.getListOrdinalSales());
              _infinityPageController = InfinityPageController(
                  initialPage: _controllerFinancePage.allYears
                      .indexOf(_controllerFinancePage.year));
            }

            return Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 11),
                    child: Text(
                      "Financias de ${_controllerFinancePage.year}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    child: _controllerFinancePage.allYears.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : InfinityPageView(
                            itemCount: _controllerFinancePage.allYears.length,
                            controller: _infinityPageController,
                            onPageChanged: (value) {
                              _controllerFinancePage.setYear(
                                  _controllerFinancePage
                                      .allYears[_infinityPageController.page]);
                              series = _createSampleData(
                                  _controllerFinancePage.getListOrdinalSales());
                            },
                            itemBuilder: (context, index) {
                              return ContentPageViewWidget(
                                average: _controllerFinancePage.media,
                                gain: _controllerFinancePage.lucre,
                                less: _controllerFinancePage.less.month,
                                more: _controllerFinancePage.more.month,
                                year: _controllerFinancePage.year,
                                infinityPageController: _infinityPageController,
                              );
                            },
                          ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 15),
                      child: charts.BarChart(
                        series,
                        barRendererDecorator:
                            new charts.BarLabelDecorator<String>(),
                        animationDuration: Duration(seconds: 1),
                        vertical: false,
                        animate: true,
                      ),
                    ),
                  ),
                ],
              );
            });
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
