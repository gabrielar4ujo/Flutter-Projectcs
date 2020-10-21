import 'package:customstore/core/calendary.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/sale_page/widgets/content_list_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSalePageAnimetedWidget extends StatelessWidget {
  final Map saleData;
  final DateTime dateTime;
  final Salesman salesman;
  final List<dynamic> productList;
  final _scrollController = ScrollController();

  CustomSalePageAnimetedWidget({@required this.saleData})
      : dateTime = saleData["time"].toDate(),
        salesman = Salesman(
            comission: saleData["salesmanComissin"],
            name: saleData["salesmanName"])
          ..clientName = saleData["clientName"],
        productList = saleData["productList"].map((mapSale) {
          Product product = Product(
              name: mapSale["productName"], categoryId: mapSale["categoryID"])
            ..spent = double.parse(mapSale["spent"])
            ..price = double.parse(mapSale["price"])
            ..categoryName = mapSale["categoryName"]
            ..selectedColor = mapSale["selectedColor"]
            ..selectedAmount = mapSale["selectedAmount"]
            ..selectedSize = mapSale["selectedSize"];

          return product;
        }).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + 7,
          ),
          Stack(alignment: Alignment.centerRight, children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  "Venda",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            IconButton(
                padding: EdgeInsets.only(left: 10),
                icon: Icon(
                  Icons.clear,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ]),
          Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + 7) -
                AppBar().preferredSize.height,
            child: ListView(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    color: Colors.grey[300],
                    child: CupertinoScrollbar(
                      isAlwaysShown: true,
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: [
                          _getWidgetText(
                            text:
                                "Venda em ${dateTime.day} de ${Calendary().getMonth(dateTime.month.toString())} de ${dateTime.year}",
                          ),
                          _getWidgetText(
                              text: "Cliente: ${saleData["clientName"]}"),
                          _getWidgetText(
                              text: "Vendedor: ${saleData["salesmanName"]}"),
                          _getWidgetText(
                              text:
                                  "Valor total das compras: R\$ ${getTotalValue().toStringAsFixed(2)}"),
                          _getWidgetText(
                              text:
                                  "Custo por cada produto: R\$ ${getTotalSpent().toStringAsFixed(2)}"),
                          _getWidgetText(
                              text:
                                  "Descontos: ${saleData["discount"].toString().contains("%") ? saleData["discount"] : "R\$ " + saleData["discount"]}"),
                          _getWidgetText(
                              text:
                                  "Quantidade total de produtos: ${getTotalAmount().toStringAsFixed(0)}"),
                          _getWidgetText(
                              text:
                                  "Lucro total: R\$ ${getGain().toStringAsFixed(2)}"),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ContentListViewWidget(
                      product: productList[index],
                      salesman: salesman,
                    );
                  },
                  shrinkWrap: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getWidgetText({@required String text, double font}) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: font ?? 15),
    );
  }

  double getTotalValue() {
    double totalValue = 0.0;
    for (Product product in productList) {
      print(product);
      totalValue += (product.price * int.parse(product.selectedAmount));
    }
    return totalValue;
  }

  double getGain() {
    double totalValue = 0.0;
    double totalSpent = 0.0;
    for (Product product in productList) {
      totalSpent += (int.parse(product.selectedAmount) * product.spent);
      totalValue += (product.price * int.parse(product.selectedAmount));
    }

    if (saleData["discount"].contains("%")) {
      totalValue -=
          (totalValue * (int.parse(saleData["discount"].split("%")[0]) / 100));
    } else {
      totalValue -= double.parse(saleData["discount"]);
    }
    totalValue -= totalSpent;

    return totalValue;
  }

  double getTotalSpent() {
    double totalSpent = 0.0;
    for (Product product in productList) {
      totalSpent += (int.parse(product.selectedAmount) * product.spent);
    }
    return totalSpent;
  }

  int getTotalAmount() {
    int totalAmount = 0;
    for (Product product in productList) {
      totalAmount += int.parse(product.selectedAmount);
    }
    return totalAmount;
  }
}
