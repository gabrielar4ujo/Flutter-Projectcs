

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/crud_sales_controller.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/add_sales_page/controllers/add_sales_controller.dart';
import 'package:customstore/pages/add_sales_page/widgets/cart_sales_widget.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../models/salesman.dart';

class AddSalesPage extends StatefulWidget {
  final ControllerLoginPage _controllerLoginPage;
  final AddSalesController _addSalesController;
  final CrudSalesController _crudSalesController;
  final List listSales;
  final String documentID;

  AddSalesPage({@required this.listSales, @required this.documentID})
      : _controllerLoginPage = GetIt.I.get<ControllerLoginPage>(),
        _addSalesController = AddSalesController(),
        _crudSalesController = CrudSalesController();

  @override
  _AddSalesPageState createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final TextStyle _textStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      bottomSheet: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        color: Colors.deepPurple,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Observer(builder: (_) {
                return Text(
                  "Total: R\$ ${widget._addSalesController.valueSalesCart.toStringAsFixed(2)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                );
              }),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              flex: 4,
              child: Observer(builder: (_) {
                return Text(
                  "Desconto: ${widget._addSalesController.discountFormated}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                );
              }),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Adicionar Venda"),
        centerTitle: false,
        actions: <Widget>[
          Observer(
            builder: (context) => IconButton(
              icon: Icon(Icons.add),
              iconSize: 30,
              disabledColor: Colors.grey[700],
              onPressed: !widget._addSalesController.amountValidator &&
                      !widget._crudSalesController.isLoading
                  ? () {
                    
                      widget._addSalesController.addSalesCartList();
                      FocusScope.of(context).unfocus();
                    }
                  : null,
            ),
          ),
          Observer(
            builder: (context) => IconButton(
              icon: Icon(Icons.check),
              iconSize: 30,
              disabledColor: Colors.grey[700],
              onPressed: widget._addSalesController.enableCheckButton &&
                      !widget._crudSalesController.isLoading
                  ? () async {
                      Salesman salesman =
                          widget._addSalesController.getFinalSalesman();

                      if (widget.documentID != null) {
                       
                        widget.listSales.add({
                          "time": Timestamp.now(),
                          "discount": widget._addSalesController.discount,
                          "productList": widget._addSalesController
                              .getFinalSalesCartList(),
                          "salesmanName": salesman.name,
                          "salesmanComission": salesman.comission.toString(),
                          "clientName": salesman.clientName,
                        });
                        await widget._crudSalesController
                            .update(
                                documentID: widget.documentID,
                                listSales: widget.listSales,
                                index: widget.listSales.length - 1)
                            .then((value) {
                          Navigator.of(context).pop(value);
                        });
                      } else {
                    
                        await widget._crudSalesController
                            .insert(
                          documentID: widget.documentID,
                          productList: widget._addSalesController
                              .getFinalSalesCartList(),
                          salesman: salesman,
                          discount: widget._addSalesController.discount,
                        )
                            .then((value) {
                        
                          Navigator.of(context).pop(value);
                        });
                      }
                    }
                  : null,
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(14),
          child: StreamBuilder(
            stream: widget._controllerLoginPage.getSalesmanListSnapshot(),
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

              if (salesmanSnapshot.data.documents.isNotEmpty)
                salesmanSnapshot.data.documents.forEach((element) {
                  salesmanList.add(Salesman(
                      name: element["name"],
                      comission: double.parse(element["comission"])));
                });
              else {
                salesmanList.add(Salesman());
              }

              return StreamBuilder(
                stream: widget._controllerLoginPage.getCategorySnapshot(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> categorySnapshot) {
                  if (categorySnapshot == null || !categorySnapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (categorySnapshot.data.documents.length == 0)
                    return Center(
                      child: Text(
                        "Seu estoque está vazio!",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );

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
                          price: double.parse(v["price"]),
                          categoryId: element.documentID);
                      product.categoryName = element["categoryName"];

                      if (salesmanList.length > 0) {
                        widget._addSalesController.salesman =
                            salesmanList.first;
                      } else {
                        widget._addSalesController.salesman = Salesman();
                      }

                      if (!productMap.containsKey(product.categoryName))
                        productMap[product.categoryName] = [product];
                      else
                        productMap[product.categoryName].add(product);
                    });
                  });

                  widget._addSalesController
                      .initAddSalesController(productMap, salesmanList);

                  return Observer(
                      builder: (context) => ListView(
                            children: <Widget>[
                              widget._addSalesController.salesmanController
                                          .salesmanName ==
                                      null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Atenção: Não há vendedores, caso prossiga, será adicionado a venda sem referência a qualquer vendedor!",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    )
                                  : Container(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                        isExpanded: true,
                                        disabledHint: Text(widget
                                            ._addSalesController
                                            .product
                                            .categoryName),
                                        decoration: InputDecoration(
                                          labelText: 'Categoria*',
                                        ),
                                        value: widget._addSalesController
                                            .product.categoryName,
                                        items: widget
                                                ._crudSalesController.isLoading
                                            ? null
                                            : widget._addSalesController
                                                .productMap.keys
                                                .map((categoryName) =>
                                                    DropdownMenuItem<String>(
                                                      value: categoryName,
                                                      child: Text(
                                                        categoryName,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: _textStyle,
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged: widget._addSalesController
                                            .setCategoryName),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                        isExpanded: true,
                                        disabledHint: Text(widget
                                                ._addSalesController
                                                .product
                                                ?.productName ??
                                            ""),
                                        decoration: InputDecoration(
                                          labelText: 'Produto*',
                                        ),
                                        value: widget._addSalesController
                                                .product.productName ??
                                            "Vazio",
                                        items: widget
                                                ._crudSalesController.isLoading
                                            ? null
                                            : (widget
                                                            ._addSalesController
                                                            .product
                                                            .productName ==
                                                        null
                                                    ? [Product(name: "Vazio")]
                                                    : widget._addSalesController
                                                            .productMap[
                                                        widget
                                                            ._addSalesController
                                                            .product
                                                            .categoryName])
                                                .map((prod) => DropdownMenuItem<String>(
                                                      value: prod.name,
                                                      child: Text(
                                                        prod.name == "Vazio"
                                                            ? "Vazio"
                                                            : prod.name +
                                                                " (R\$ ${widget._addSalesController.getProduct(prod.name).price.toStringAsFixed(2)})",
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: _textStyle,
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged: widget._addSalesController.setProductName),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 74,
                                    child: DropdownButtonFormField(
                                        isExpanded: true,
                                        disabledHint: Text(widget
                                                ._addSalesController
                                                .product
                                                ?.size ??
                                            ""),
                                        decoration: InputDecoration(
                                          labelText: 'Tamanho*',
                                        ),
                                        value: widget._addSalesController
                                                .product.size ??
                                            "Vazio",
                                        items: widget
                                                ._crudSalesController.isLoading
                                            ? null
                                            : (widget._addSalesController
                                                            .product.size ==
                                                        null
                                                    ? ["Vazio"]
                                                    : widget._addSalesController
                                                        .product.colorMap.keys
                                                        .toList())
                                                .map((size) =>
                                                    DropdownMenuItem<String>(
                                                      value: size,
                                                      child: Text(
                                                        size,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: _textStyle,
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged:
                                            widget._addSalesController.setSize),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: DropdownButtonFormField(
                                        isExpanded: true,
                                        disabledHint: Text(widget
                                                ._addSalesController
                                                .product
                                                ?.color ??
                                            ""),
                                        decoration: InputDecoration(
                                          labelText: 'Cor*',
                                        ),
                                        value: widget._addSalesController
                                                .product.color ??
                                            "Vazio",
                                        items: widget
                                                ._crudSalesController.isLoading
                                            ? null
                                            : (widget._addSalesController
                                                        .getListColors() ??
                                                    ["Vazio"])
                                                .map((color) =>
                                                    DropdownMenuItem<String>(
                                                      value: color,
                                                      child: Text(
                                                        color == "Vazio"
                                                            ? color
                                                            : color +
                                                                " (${widget._addSalesController.product.colorMap[widget._addSalesController.product.size][color]["amount"]})",
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: _textStyle,
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged: widget
                                            ._addSalesController.setColor),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: DropdownButtonFormField(
                                        isExpanded: true,
                                        disabledHint: Text(widget
                                                ._addSalesController
                                                .salesmanController
                                                ?.salesmanName ??
                                            ""),
                                        decoration: InputDecoration(
                                          labelText: 'Vendedor*',
                                        ),
                                        value: widget
                                                ._addSalesController
                                                .salesmanController
                                                .salesmanName ??
                                            "Vazio",
                                        items: widget
                                                ._crudSalesController.isLoading
                                            ? null
                                            : widget._addSalesController
                                                .listSalesman
                                                .map((salesman) =>
                                                    DropdownMenuItem<String>(
                                                      value: salesman.name ??
                                                          "Vazio",
                                                      child: Text(
                                                        salesman.name ??
                                                            "Vazio",
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: _textStyle,
                                                      ),
                                                    ))
                                                .toList(),
                                        onChanged: widget
                                            ._addSalesController.setSalesman),
                                  ),
                                ],
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: widget._addSalesController
                                    .clientNameTextEditingController,
                                onChanged:
                                    widget._addSalesController.setClientName,
                                enabled: !widget._crudSalesController.isLoading,
                                decoration: InputDecoration(
                                    labelText: "Nome do Cliente*",
                                    hintText: "Ex: Maria",
                                    errorText: widget._addSalesController
                                        .clientNameError()),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      controller: widget._addSalesController
                                          .discountTextEditingController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.%]")),
                                      ],
                                      // onChanged: widget
                                      //     ._addSalesController.setDiscount,
                                      enabled: !widget
                                          ._crudSalesController.isLoading,
                                      decoration: InputDecoration(
                                        helperText: "",
                                        labelText: "Desconto",
                                        hintText: "Ex: 5.00 ou 5%",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      enabled: widget
                                              ._addSalesController
                                              .product
                                              .amountIsNotNullAndNotEmpty &&
                                          !widget
                                              ._crudSalesController.isLoading,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: false),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      controller: widget._addSalesController
                                          .amountTextEditingController,
                                      decoration: InputDecoration(
                                        helperText: "",
                                        errorText: widget._addSalesController
                                            .amountError(),
                                        labelText: "Quantidade*",
                                        hintText:
                                            "Max: ${widget._addSalesController.product.amount ?? 0}",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Observer(builder: (_) {
                                return CartSalesWidget(
                                  removeSalesCartList: widget
                                      ._addSalesController.removeSalesCartList,
                                  amountCartSales: widget
                                      ._addSalesController.amountSalesCartList,
                                  salesCart:
                                      widget._addSalesController.salesCartList,
                                );
                              }),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ));
                },
              );
            },
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._addSalesController.disposeAll();
  }
}
