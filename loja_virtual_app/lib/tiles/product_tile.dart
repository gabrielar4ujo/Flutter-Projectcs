import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/datas/product_data.dart';
import 'package:loja_virtual_app/screens/products_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell( //Poderia ser um GestureDetector, diferença que o InkWell tem efeito de toque
      onTap: (){
        print(product.title);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
      child:Card(
        child: type == "grid" ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: .8,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "R\$ ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
            :
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "R\$ ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
