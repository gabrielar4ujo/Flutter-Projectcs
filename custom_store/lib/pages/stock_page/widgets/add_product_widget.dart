import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';

class AddProductWidget extends StatelessWidget {
  final Map<String, dynamic> allProductsName;
  final String userUID;
  final String documentID;
  final CrudProductController _crudProductController;

  AddProductWidget(
      {Key key, this.allProductsName, this.userUID, @required this.documentID})
      : _crudProductController = CrudProductController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(allProductsName.keys.toList());
        Product product = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  categoryID: documentID,
                  allProductsName: allProductsName.keys.toList(),
                )));

        if (product != null) {
          allProductsName[product.name] = product.toJson();
          _crudProductController.insert(
              categoryName: documentID, productData: allProductsName);
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
