import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/widgets/custom_text_field_widget.dart';
import 'package:customstore/pages/product_page/product_page.dart';
import 'package:customstore/pages/stock_page/category_controller.dart';
import 'package:customstore/pages/stock_page/stock_page_controller.dart';
import 'package:customstore/pages/stock_page/widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  ControllerLoginPage controllerLoginPage;
  StockPageController stockPageController;


  @override
  void initState() {
    super.initState();
    stockPageController = StockPageController();
    controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Estoque"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //title: Text("Digite o nome da categoria"),
                    content: Observer(
                        builder: (context) => CustomTextFieldWidget(
                              obscure: false,
                              enabled: true,
                              labelText: "Categoria",
                              function: stockPageController.setProductText,
                              eyeFunction: null,
                              error: stockPageController.productValidator(),
                              color: Colors.black,
                            )),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                          stockPageController.productText = '';
                        },
                        child: Text("Cancelar"),
                      ),
                      Observer(
                        builder: (context) => FlatButton(
                          onPressed: stockPageController.productText.isNotEmpty ? (){
                            stockPageController.dialogConfirm();
                            Navigator.pop(context);
                            stockPageController.productText = '';
                          } : null,
                          child: Text("Adicionar"),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("stores").document(controllerLoginPage.user.uid).collection("stock").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          else {
            return Container(
              margin: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot doc = snapshot.data.documents[index];
                  CategoryController categoryController = CategoryController(category: doc.documentID, uidUser: controllerLoginPage.user.uid);
                  print("Ver dados: ${categoryController.observableMap}");
                  return Observer(
                    builder: (context) {

                      print("isloading ${categoryController.isLoading}");
                      if(categoryController.isLoading) return Container();

                      print("lenght ${categoryController.observableMap.length}");

                      return GestureDetector(
                        onLongPress: (){
                          print("onLongPress expasion tile");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          margin: EdgeInsets.only(bottom: 12),
                          child: ExpansionTile(
                            onExpansionChanged: categoryController.onExpanded,
                            title: Text(snapshot.data.documents[index].data["categoryName"], style: TextStyle(color: Colors.black),),
                            trailing: Observer(
                              builder: (context) => Icon(
                                categoryController.isExpanded ? Icons.expand_less : Icons.expand_more,
                              ),
                            ),
                            children: categoryController.observableMap.map((element) {
                              //print();
                              return GestureDetector(
                                onTap: (){
                                  print("onTap Produto: ${element.name}");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage()));
                                  },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width:.5),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
                                  child: ProductTileWidget(element: element,)
                                ),
                              );
                            }
                            ).toList()..add( GestureDetector(
                              onTap: (){print("onTap Adicionar");},
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(icon: Icon(Icons.add, color: Colors.deepPurpleAccent,), onPressed: () {  },),
                                    Text("Adicionar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ),
                      );
                    },
                  );
                },

              ),
            );
          }
      },

      ),
    );
  }
}
