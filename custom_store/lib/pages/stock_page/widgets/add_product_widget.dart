import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/product_helper.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';

class AddProductWidget extends StatelessWidget {

  final Map<String,dynamic> allProductsName;
  final DocumentSnapshot snapshot;
  final String userUID;
  ProductHelper productHelper;

  AddProductWidget({Key key, this.allProductsName, this.snapshot, this.userUID}){
    productHelper = ProductHelper();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        print(allProductsName.keys.toList());
        Product product = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
              categoryID: snapshot.documentID,
              allProductsName: allProductsName.keys.toList(),
            )));

        if(product != null){
          allProductsName[product.name] = product.toJson();
          productHelper.insert( snapshot.documentID, productData: allProductsName);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(Icons.add, color: Colors.deepPurpleAccent,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Adicionar", style: TextStyle(fontSize: 17),),
            )
          ],
        ),
      ),
    );
  }
}
