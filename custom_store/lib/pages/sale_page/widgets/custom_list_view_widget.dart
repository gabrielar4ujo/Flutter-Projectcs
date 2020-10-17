import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:customstore/core/calendary.dart';
import 'package:customstore/pages/sale_page/widgets/custom_list_tile_widget.dart';
import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  final Map salesMap;

  CustomListViewWidget({this.salesMap});

  @override
  Widget build(BuildContext context) {
    salesMap.remove("time");
    // print("---------------");
    // print(salesMap);
    // print("---------------");
    int index = -1;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: salesMap.keys.map((salesMonth) {
        List productsInSaleMonth = salesMap[salesMonth];

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
            children: productsInSaleMonth.map((saleData) {
              DateTime dateTime =
                  DateTime.parse(saleData["time"].toDate().toString());
              return CustomListTileWidget(
                dateTime: dateTime,
                saleData: saleData,
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
