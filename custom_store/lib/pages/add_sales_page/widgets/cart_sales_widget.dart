import 'package:flutter/material.dart';

import '../../../models/product.dart';

class CartSalesWidget extends StatelessWidget {
  final List<Product> salesCart;
  final int amountCartSales;

  CartSalesWidget({@required this.salesCart, @required this.amountCartSales});

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
              onTap: () {},

              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  print("OnTapButtonDelete");
                },
              ),
            ),
          );
        });
  }
}
