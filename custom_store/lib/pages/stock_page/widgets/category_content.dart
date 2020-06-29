import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';

import 'product_tile_widget.dart';

class CategoryContentWidget extends StatelessWidget {

  final Product product;
  final Map<String,dynamic> allProductsName;
  final String userUID;
  final DocumentSnapshot snapshot;

  const CategoryContentWidget({Key key, this.product, this.allProductsName, this.userUID, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { //FALTA IMPLEMENTAR O EDITAR
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
              categoryID: product.categoryId,
              product: product,
              allProductsName: allProductsName.keys.toList(),
            )));
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(
              left: 8, right: 8, bottom: 10),
          child: ProductTileWidget(
            product: product,
          )),
    );
  }
}
