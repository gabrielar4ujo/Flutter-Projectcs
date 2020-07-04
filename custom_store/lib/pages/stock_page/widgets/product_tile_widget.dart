import 'package:customstore/models/product.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final Product product;

  const ProductTileWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading:

              product.listPictures.isEmpty ? Image.asset("assets/cabide.png",
              fit: BoxFit.cover,
              color: Colors.deepPurpleAccent,
              width: 40,
              height: 40,
            ):
              ClipOval(
                child: FadeInImage(
                  placeholder: AssetImage("assets/loading.gif"),
                  image: NetworkImage(product.listPictures.first),
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),


          title: Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
          trailing: Text(
            "R\$${product.price.toStringAsFixed(2)}",
            maxLines: 2,
            //textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                "Em estoque: ${product.amount.toString()}",
                maxLines: 2,
                //textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                "Gasto: ${product.spent.toStringAsFixed(2)}",
                maxLines: 2,
                //textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
