import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/pages/sale_page/controllers/sale_page_controller.dart';
import 'package:customstore/pages/sale_page/widgets/custom_list_tile_widget.dart';
import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  final Map salesMap;
  final SalesPageController salesPageController;
  final String documentID;

  CustomListViewWidget(
      {this.salesMap,
      @required this.salesPageController,
      @required this.documentID});

  @override
  Widget build(BuildContext context) {
    int productIndex = -1;
    int index = -1;
    //print(documentID);
    salesMap.remove("time");
    // print("---------------");
    // print(salesMap);
    // print("---------------");

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: salesMap.keys.map((salesMonth) {
        print(salesMonth);
        List productsInSaleMonth = salesMap[salesMonth];
        print(productsInSaleMonth);

        index++;
        return Card(
          margin: EdgeInsets.only(
              top: index == 0 ? 20 : 6,
              left: 12,
              right: 12,
              bottom: index == salesMap.length - 1 ? 92 : 6),
          child: ConfigurableExpansionTile(
            animatedWidgetFollowingHeader: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Icon(
                Icons.expand_more,
                color: const Color(0xFF707070),
              ),
            ),
            header: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                child: Text(
                  Calendary().getMonth(salesMonth),
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            children: productsInSaleMonth.isEmpty
                ? [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Não há vendas nesse mês",
                        style:
                            TextStyle(fontSize: 15, color: Colors.deepPurple),
                      ),
                    )
                  ]
                : productsInSaleMonth.map((saleData) {
                    productIndex++;
                    DateTime dateTime =
                        DateTime.parse(saleData["time"].toDate().toString());
                    return CustomListTileWidget(
                      documentID: documentID,
                      salesMonth: salesMonth,
                      salesPageController: salesPageController,
                      dateTime: dateTime,
                      saleData: saleData,
                      index: productIndex,
                    );
                  }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
