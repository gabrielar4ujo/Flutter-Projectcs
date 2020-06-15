import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/datas/product_data.dart';
import 'package:loja_virtual_app/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.grid_off),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("products")
                .document(this.snapshot.documentID)
                .collection("items")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    GridView.builder(
                      // Para não carregar todos os itens ao mesmo tempo, carrega ao longo do scroll
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65),
                      //Responsável po
                      itemCount: snapshot.data.documents.length,
                      // r dizer quandos itens na horizontal
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductTile(
                            "grid", data);
                      },
                      padding: EdgeInsets.all(4),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ProductTile(
                            "list",
                            ProductData.fromDocument(
                                snapshot.data.documents[index]));
                      },
                      padding: EdgeInsets.all(4),
                      itemCount: snapshot.data.documents.length,
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
