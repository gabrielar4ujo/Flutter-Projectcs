import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/product_helper.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/stock_page/category_controller.dart';
import 'package:customstore/pages/stock_page/widgets/add_product_widget.dart';
import 'package:customstore/pages/stock_page/widgets/bottom_text_field_widget.dart';
import 'package:customstore/pages/stock_page/widgets/category_content.dart';
import 'package:customstore/pages/stock_page/widgets/custom_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ControllerLoginPage controllerLoginPage;
  ProductHelper productHelper;

  @override
  void initState() {
    super.initState();
    controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    productHelper = ProductHelper();
  }

  void showSnackbar({bool result, String type}) async {
    print("Type: $type");
    await Future.delayed(Duration(milliseconds: 500));
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: result ? 1 : 3),
      backgroundColor: Colors.deepPurple,
      content: Text(type == "INSERT"
          ? result
              ? "Categoria ADICIONADA com sucesso!"
              : "Problema de conexão! Dado ADICIONADO apenas localmente!"
          : type == "UPDATE"
              ? result
                  ? "Categoria RENOMEADA com sucesso!"
                  : "Problema de conexão! Dado RENOMEADO apenas localmente!"
              : result
                  ? "Categoria DELETADA com sucesso!"
                  : "Problema de conexão! Dado DELETADO apenas localmente!"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Estoque"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              var bottomSheetController = showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BottomTextFieldWidget();
                  });
              bottomSheetController.then((listValue) {
                print("bottomSHeet: $listValue");
                if (listValue != null)
                  showSnackbar(result: listValue[0], type: listValue[1]);
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: controllerLoginPage.getCategorySnapshot(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.hasError)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text(
                "Adicione alguma categoria!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot categorySnapshot =
                      snapshot.data.documents[index];
                  CategoryController categoryController = CategoryController(
                      category: categorySnapshot.documentID,
                      uidUser: controllerLoginPage.user.uid);
                  print("Ver dados: ${categoryController.observableMap}");
                  Map<String, dynamic> allProductsList =
                      categorySnapshot.data["listProducts"] ?? Map();

                  return Observer(
                    builder: (context) {
                      print("isloading ${categoryController.isLoading}");
                      if (categoryController.isLoading) return Container();

                      print(
                          "lenght ${categoryController.observableMap.length}");

                      return GestureDetector(
                        onLongPress: () {
                          print("onLongPress expasion tile");
                          var bottomSheetController = showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return CustomBottomSheetWidget(
                                allProductsList: allProductsList,
                                lastName: snapshot
                                    .data.documents[index].data["categoryName"],
                                documentID: categorySnapshot.documentID,
                                userUID: controllerLoginPage.user.uid,
                              );
                            },
                          );
                          bottomSheetController.then((listValue) {
                            if (listValue != null)
                              showSnackbar(
                                  result: listValue[0], type: listValue[1]);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(bottom: 12),
                          child: ExpansionTile(
                            onExpansionChanged: categoryController.onExpanded,
                            title: Text(
                              categorySnapshot.data["categoryName"],
                              style: TextStyle(color: Colors.black),
                            ),
                            children:
                                categoryController.observableMap.map((product) {
                              return Container(
                                  child: CategoryContentWidget(
                                userUID: controllerLoginPage.user.uid,
                                documentID: categorySnapshot.documentID,
                                allProductsName: allProductsList,
                                product: product,
                              ));
                            }).toList()
                                  ..add(Container(
                                      child: AddProductWidget(
                                    allProductsName: allProductsList,
                                    userUID: controllerLoginPage.user.uid,
                                    documentID: categorySnapshot.documentID,
                                  ))),
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
