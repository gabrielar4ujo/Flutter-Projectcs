import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/crud_sales_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/add_sales_page/controllers/add_sales_controller.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AddSalesPage extends StatelessWidget {

  final ControllerLoginPage _controllerLoginPage;
  final AddSalesController _addSalesController;
  final CrudSalesController _salesHelper;

  AddSalesPage() : _controllerLoginPage = GetIt.I.get<ControllerLoginPage>(),  _addSalesController = AddSalesController(), _salesHelper = CrudSalesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Venda"),
        centerTitle: false,
        actions: <Widget>[
          Observer(
            builder: (context) => IconButton(
              icon: Icon(Icons.check),
              iconSize: 30,
              disabledColor: Colors.grey[700],
              onPressed: _addSalesController.enableButton && !_salesHelper.isLoading ? () async {
                Product p = _addSalesController.getFinalProduct();
                await _salesHelper.insert(categoryName: p.categoryId ,productData: p).then((value) {
                  Navigator.of(context).pop(value);
                });
              } : null,
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
            stream: _controllerLoginPage.getSalesmanListSnapshot(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> salesmanSnapshot) {
              if (!salesmanSnapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Carregando dados...")
                    ],
                  ),
                );
              }

              List<Salesman> salesmanList = List();

              salesmanSnapshot.data.documents.forEach((element) {
                salesmanList.add(Salesman(
                    name: element["name"],
                    comission: double.parse(element["comission"])));
              });

              print(salesmanList);

              return StreamBuilder(
                stream: _controllerLoginPage.getCategorySnapshot(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> categorySnapshot) {
                  print("CategorySnapshto");
                  if (categorySnapshot == null || !categorySnapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (categorySnapshot.data.documents.length == 0)
                    return Center(
                      child: Text(
                        "Seu estoque está vazio!",
                        style: TextStyle(color: Colors.deepPurple, fontSize: 20,),
                        textAlign: TextAlign.center,
                      ),
                    );

                  print("CategorySnapshto");
                  Map<String, List<Product>> productMap = Map();

                  categorySnapshot.data.documents.forEach((element) {
                    if (!element.data.containsKey("listProducts")) {
                      Product product = Product(categoryId: element.documentID);
                      product.categoryName = element["categoryName"];
                      productMap[product.categoryName] = [product];
                    }
                    element["listProducts"]?.forEach((k, v) {
                      Product product = Product(
                          name: k,
                          features: v["features"],
                          categoryId: element.documentID);
                      product.categoryName = element["categoryName"];

                      if (salesmanList.length > 0) {
                        product.salesman = salesmanList.first;
                      } else {
                        product.salesman = Salesman();
                      }

                      if (!productMap.containsKey(product.categoryName))
                        productMap[product.categoryName] = [product];
                      else
                        productMap[product.categoryName].add(product);
                    });
                  });

                  _addSalesController.initAddSalesController(productMap, salesmanList);

                  return Observer(
                      builder: (context) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                      disabledHint: Text(_addSalesController.product.categoryName),
                                        decoration: InputDecoration(
                                          labelText: 'Categoria*',
                                        ),
                                        value: _addSalesController
                                            .product.categoryName,
                                        items: _salesHelper.isLoading ? null : _addSalesController
                                            .productMap.keys
                                            .map((categoryName) =>
                                                DropdownMenuItem<String>(
                                                  value: categoryName,
                                                  child: Text(
                                                    categoryName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: _addSalesController
                                            .setCategoryName),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                        disabledHint: Text(_addSalesController.product?.productName ?? ""),
                                        decoration: InputDecoration(
                                          labelText: 'Produto*',
                                        ),
                                        value: _addSalesController
                                                .product.productName ??
                                            "Vazio",
                                        items: _salesHelper.isLoading ? null : (_addSalesController
                                                        .product.productName ==
                                                    null
                                                ? [Product(name: "Vazio")]
                                                : _addSalesController
                                                        .productMap[
                                                    _addSalesController
                                                        .product.categoryName])
                                            .map((prod) =>
                                                DropdownMenuItem<String>(
                                                  value: prod.name,
                                                  child: Text(
                                                    prod.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged:
                                            _addSalesController.setProductName),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 74,
                                    child: DropdownButtonFormField(
                                        disabledHint: Text(_addSalesController.product?.size ?? ""),
                                        decoration: InputDecoration(
                                          labelText: 'Tamanho*',
                                        ),
                                        value:
                                            _addSalesController.product.size ??
                                                "Vazio",
                                        items:
                                        _salesHelper.isLoading ? null : (_addSalesController.product.size ==
                                                        null
                                                    ? ["Vazio"]
                                                    : [
                                                        "P",
                                                        "M",
                                                        "G",
                                                        "GG",
                                                        "XG",
                                                        "U"
                                                      ])
                                                .map((size) =>
                                                    DropdownMenuItem<String>(
                                                      value: size,
                                                      child: Text(
                                                        size,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged: _addSalesController.setSize),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: DropdownButtonFormField(
                                        disabledHint: Text(_addSalesController.product?.color ?? ""),
                                        decoration: InputDecoration(
                                          labelText: 'Cor*',
                                        ),
                                        value:
                                            _addSalesController.product.color ??
                                                "Vazio",
                                        items: _salesHelper.isLoading ? null : _addSalesController
                                            .getListColors()
                                            .map((size) =>
                                                DropdownMenuItem<String>(
                                                  value: size,
                                                  child: Text(
                                                    size,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged:
                                            _addSalesController.setColor),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: DropdownButtonFormField(
                                        disabledHint: Text(_addSalesController.salesmanController?.salesmanName ?? ""),
                                        decoration: InputDecoration(
                                          labelText: 'Vendedor*',
                                        ),
                                        value: _addSalesController
                                            .salesmanController.salesmanName,
                                        items: _salesHelper.isLoading ? null : _addSalesController.listSalesman
                                            .map((salesman) =>
                                                DropdownMenuItem<String>(
                                                  value: salesman.name,
                                                  child: Text(
                                                    salesman.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged:
                                            _addSalesController.setSalesman),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 4,
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      controller: _addSalesController
                                          .clientNameTextEditingController,
                                      onChanged:
                                          _addSalesController.setClientName,
                                      enabled: _addSalesController
                                          .product.amountIsNotNull && !_salesHelper.isLoading,
                                      decoration: InputDecoration(
                                          labelText: "Nome do Cliente*",
                                          hintText: "Ex: Maria",
                                          errorText: _addSalesController
                                              .clientNameError()),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: TextFormField(
                                      enabled: _addSalesController
                                          .product.amountIsNotNull && !_salesHelper.isLoading,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: false),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      controller: _addSalesController
                                          .amountTextEditingController,
                                      onChanged:
                                          _addSalesController.setSelectedAmount,
                                      decoration: InputDecoration(
                                        errorText:
                                            _addSalesController.amountError(),
                                        labelText: "Quantidade*",
                                        hintText:
                                            "Max: ${_addSalesController.product.amount ?? 0}",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ));
                },
              );
            },
          )),
    );
  }
}
