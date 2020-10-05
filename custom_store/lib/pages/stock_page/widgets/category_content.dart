

import 'package:customstore/core/crud_category_controller.dart';
import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'product_tile_widget.dart';

class CategoryContentWidget extends StatelessWidget {
  final Product product;
  final Map<String, dynamic> allProductsName;
  final String userUID;
  final String documentID;
  final String categoryName;
  final CrudProductController _crudProductController;

  CategoryContentWidget(
      {this.product,
      this.allProductsName,
      this.userUID,
      @required this.categoryName,
      @required this.documentID})
      : _crudProductController = CrudProductController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        GetIt.I
            .get<ControllerLoginPage>()
            .categorySnapshotListen(categoryID: documentID);

        Product productEdited =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPage(
                      categoryID: product.categoryId,
                      product: product,
                      allProductsName: allProductsName.keys.toList(),
                    )));

        Map allProductsMapWithAlteration =
            GetIt.I.get<ControllerLoginPage>().categoryEvent;

        if (productEdited != null) {
          if (GetIt.I.get<ControllerLoginPage>().hasCategory != null &&
              !GetIt.I.get<ControllerLoginPage>().hasCategory) {
            CrudCategoryController crudCategoryController =
                CrudCategoryController();
        
            await crudCategoryController.insert(
                categoryName: categoryName, documentID: documentID);
          }
          if (allProductsMapWithAlteration == null) {
            if (productEdited.name != product.name)
              allProductsName.remove(product.name);

            if (productEdited.name != null)
              allProductsName[productEdited.name] = productEdited.toJson();

            _crudProductController
                .update(documentID: documentID, productData: allProductsName)
                .then((value) => GetIt.I
                    .get<ControllerLoginPage>()
                    .categorySnapshotCancel());
          } else {
            if (productEdited.name != product.name) {
              try {
                allProductsMapWithAlteration.remove(product.name);
              } catch (e) {
            
              }
            }
            if (productEdited.name != null) {
              allProductsMapWithAlteration[productEdited.name] =
                  productEdited.toJson();
              _crudProductController
                  .update(
                      documentID: documentID,
                      productData: allProductsMapWithAlteration)
                  .then((value) => GetIt.I
                      .get<ControllerLoginPage>()
                      .categorySnapshotCancel());
            }
          }
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
