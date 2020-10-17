import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/sale_page/widgets/content_list_view_widget.dart';
import 'package:flutter/material.dart';

class CustomSalePageAnimetedWidget extends StatelessWidget {
  final Map saleData;

  CustomSalePageAnimetedWidget({@required this.saleData});

  @override
  Widget build(BuildContext context) {
    //print(saleData);
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
                  "Vendas",
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
            child: ListView.builder(
              itemCount: saleData["productList"].length,
              itemBuilder: (context, index) {
                Map mapSale = saleData["productList"][index];
                Product p = Product(
                    name: mapSale["productName"],
                    categoryId: mapSale["categoryID"])
                  ..categoryName = mapSale["categoryName"]
                  ..selectedColor = mapSale["selectedColor"]
                  ..selectedAmount = mapSale["selectedAmount"]
                  ..selectedSize = mapSale["selectedSize"];

                Salesman s = Salesman(
                    comission: saleData["salesmanComissin"],
                    name: saleData["salesmanName"])
                  ..clientName = saleData["clientName"];

                return ContentListViewWidget(
                  product: p,
                  salesman: s,
                );
              },
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
