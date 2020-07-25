import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';

import 'product_tile_widget.dart';

class CategoryContentWidget extends StatelessWidget {
  final Product product;
  final Map<String, dynamic> allProductsName;
  final String userUID;
  final String documentID;
  final CrudProductController _crudProductController;

  CategoryContentWidget(
      {this.product,
      this.allProductsName,
      this.userUID,
      @required this.documentID})
      : _crudProductController = CrudProductController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Product productEdited =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPage(
                      categoryID: product.categoryId,
                      product: product,
                      allProductsName: allProductsName.keys.toList(),
                    )));

        if (productEdited != null) {
          if (productEdited.name != product.name)
            allProductsName.remove(product.name);

          if (productEdited.name != null)
            allProductsName[productEdited.name] = productEdited.toJson();
          _crudProductController.update(
              documentID: documentID, productData: allProductsName);
        }
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
          child: ProductTileWidget(
            product: product,
          )),
    );
  }
}
