import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/pages/finance_page/controllers/controller_finance_page.dart';
import 'package:customstore/pages/finance_page/widgets/horizontal_bar_chat.dart';
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
  String year = DateTime.now().year.toString();
  ControllerFinancePage _controllerFinancePage = ControllerFinancePage();

  final InfinityPageController _infinityPageController =
      InfinityPageController(initialPage: 0);

  List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<OrdinalSales> listData) {
    //AHCO MELHOR PASSAR MAP EM VEZ DE LIST

    bool containsInListData = false;

    print(
        "CONTAINS: ${listData.contains(OrdinalSales(Calendary().getMonth(10.toString()).substring(0, 3).toUpperCase(), 1))}");
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
            null));
    }

    listData.sort();

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
        domainFn: (OrdinalSales sales, _) => sales.month,
        //seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
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
              //print(snapshot.data.documents[0] is DocumentSnapshot);
              _controllerFinancePage
                  .createMapWithSales(snapshot.data.documents);
              series = _createSampleData(
                  _controllerFinancePage.getListOrdinalSales());
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
                    child: InfinityPageView(
                      itemCount: _controllerFinancePage.salesMap.length + 2,
                      controller: _infinityPageController,
                      onPageChanged: (value) {
                        _controllerFinancePage
                            .setYear((DateTime.now().year + value).toString());
                        series = _createSampleData(
                            _controllerFinancePage.getListOrdinalSales());
                      },
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                        ),
                                        onPressed: () {
                                          _infinityPageController.jumpToPage(
                                            _infinityPageController.page - 1,
                                          );
                                        }),
                                    Text(
                                      _controllerFinancePage.year,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        ),
                                        onPressed: () {
                                          _infinityPageController.jumpToPage(
                                            _infinityPageController.page + 1,
                                          );
                                        }),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 52,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Lucro total: R\$ 1000.00"),
                                      Text("Mês com maior lucro: R\$ 1000.00"),
                                      Text("Mês com menor lucro: R\$ 1000.00"),
                                      Text(
                                          "Média de todos os meses: R\$ 1000.00"),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            // Center(
                            //   child: Text(
                            //       "AQUI VAI FICAR OS DADOS DE ${DateTime.now().year + index}"),
                            // ),

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
}
