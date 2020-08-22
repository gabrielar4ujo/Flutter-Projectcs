import 'dart:developer';

import 'package:customstore/pages/add_sales_page/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class CartSalesWidget extends StatelessWidget {
  final List<Product> salesCart;
  final int amountCartSales;
  final Function removeSalesCartList;

  CartSalesWidget(
      {@required this.salesCart,
      @required this.amountCartSales,
      @required this.removeSalesCartList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: amountCartSales,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Product product = salesCart[index];
          return Card(
            child: ListTile(
              //contentPadding: EdgeInsets.zero,
              title: Text(
                product.name,
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                product.selectedAmount,
                style: TextStyle(fontSize: 14),
              ),
              dense: true,
              onTap: () {
                log("Show Sale Content");
                showDialog(
                    context: context,
                    builder: (context) => CustomDialogWidget(
                          product: product,
                        ));
              },

              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  removeSalesCartList(product, index);
                },
              ),
            ),
          );
        });
  }
}
