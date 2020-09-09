import 'dart:developer';

import 'package:customstore/core/crud_category_controller.dart';
import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';

import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddProductWidget extends StatelessWidget {
  final Map<String, dynamic> allProductsName;
  final String userUID;
  final String documentID;
  final String categoryName;
  final CrudProductController _crudProductController;

  AddProductWidget(
      {Key key,
      this.allProductsName,
      this.userUID,
      @required this.documentID,
      @required this.categoryName})
      : _crudProductController = CrudProductController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //print(allProductsName.keys.toList());
        GetIt.I
            .get<ControllerLoginPage>()
            .categorySnapshotListen(categoryID: documentID);
        Product product = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  categoryID: documentID,
                  allProductsName: allProductsName.keys.toList(),
                )));

        print("Map atualizado?");
        Map allProductsMapWithAlteration =
            GetIt.I.get<ControllerLoginPage>().categoryEvent;
        print(GetIt.I.get<ControllerLoginPage>().categoryEvent);

        if (product != null) {
          if ( GetIt.I.get<ControllerLoginPage>().hasCategory != null && !GetIt.I.get<ControllerLoginPage>().hasCategory) {
            CrudCategoryController crudCategoryController =
                CrudCategoryController();
            log("######################################################");
            log(categoryName);
            log(documentID);
            log("######################################################");
            await crudCategoryController.insert(
                categoryName: categoryName, documentID: documentID);
            print("Esperei NO ADDPRODUCT");
          }
          if (allProductsMapWithAlteration == null) {
            print("First");
            allProductsName[product.name] = product.toJson();

            _crudProductController
                .insert(categoryName: documentID, productData: allProductsName)
                .whenComplete(() => GetIt.I
                    .get<ControllerLoginPage>()
                    .categorySnapshotCancel());
          } else {
            print("Second");
            allProductsMapWithAlteration[product.name] = product.toJson();
            _crudProductController
                .insert(
                    categoryName: documentID,
                    productData: allProductsMapWithAlteration)
                .then((value) => GetIt.I
                    .get<ControllerLoginPage>()
                    .categorySnapshotCancel());
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.deepPurpleAccent,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Adicionar",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
