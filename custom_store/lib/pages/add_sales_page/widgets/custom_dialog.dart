import 'package:customstore/models/product.dart';
import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final Product product;

  CustomDialogWidget({@required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.only(right: 18),
        contentPadding:
            EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 12),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    "${product.categoryName}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    product.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Cor: ${product.selectedColor}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Tam: ${product.selectedSize}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Quant: ${product.selectedAmount}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Valor: R\$ ${product.price.toStringAsFixed(2)}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              "Fechar",
              style: TextStyle(color: Colors.deepPurple),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
