import 'package:customstore/datas/product.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {

  final Product element;

  const ProductTileWidget({Key key, @required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset("assets/cabide.png",
              fit: BoxFit.cover,
              color: Colors.deepPurpleAccent,
              width: 35,
              height: 35,
            ),
          ),
          title:  Text(
            element.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
          trailing: Text(
            "R\$${element.price.toStringAsFixed(2)}",
            maxLines: 2,
            //textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 4,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                "Em estoque: ${element.amount.toString()}",
                maxLines: 2,
                //textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                "Gasto: ${element.price.toStringAsFixed(2)}",
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
