import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../models/product.dart';
import 'product_controller.dart';
import 'saleman_controller.dart';

part 'add_sales_controller.g.dart';

class AddSalesController = _AddSalesController with _$AddSalesController;

abstract class _AddSalesController with Store {
  _AddSalesController({productMap, listSalesman}) {
    if (productMap != null || listSalesman != null) {
      initAddSalesController(productMap, listSalesman);
    }
  }

  void initAddSalesController(
      Map<String, List<Product>> productMap, List<Salesman> listSalesman) {
    String firstProduct = productMap.keys?.first;
    this.productMap = productMap;
    this.listSalesman = listSalesman;
    if (firstProduct != null) {
      _productController.changeProductSale(productMap[firstProduct].first);
      _salesmanController.setSalesman(listSalesman.first);
    }
    // print("PRODUCT MAP");
    // print(productMap);
  }

  TextEditingController amountTextEditingController = TextEditingController();

  TextEditingController clientNameTextEditingController =
      TextEditingController();

  TextEditingController discountTextEditingController = TextEditingController();

  List<Product> listProduct;
  List<Salesman> listSalesman;

  List<Product> salesCartList = List<Product>();

  @observable
  int amountSalesCartList = 0;

  void modifyProductMapQuantity(Product product, String amount) {
    getProduct(product.name).features[product.selectedSize]
        [product.selectedColor]["amount"] = amount;
    print("Modificado em: $amount");
    print(productMap);
  }

  void removeSalesCartList(Product p, int index) {
    String amount = (int.parse(p.selectedAmount) +
            int.parse(getProduct(p.name, categoryName: p.categoryName)
                .features[p.selectedSize][p.selectedColor]["amount"]))
        .toString();
    modifyProductMapQuantity(p, amount);
    salesCartList.removeAt(index);
    amountSalesCartList--;
    if (getFinalProduct().equals(p)) _productController.setAmount(amount);
  }

  void addSalesCartList() {
    Product finalProduct = getFinalProduct();

    for (Product p in salesCartList) {
      if (finalProduct.equals(p)) {
        p.selectedAmount = (int.parse(p.selectedAmount) +
                int.parse(finalProduct.selectedAmount))
            .toString();
        amountSalesCartList = amountSalesCartList;
        resetFormFields();
        _productController.setAmount((int.parse(_productController.amount) -
                int.parse(finalProduct.selectedAmount))
            .toString());
        modifyProductMapQuantity(finalProduct, _productController.amount);
        return;
      }
    }

    salesCartList.add(finalProduct);
    amountSalesCartList++;
    _productController.setAmount((int.parse(_productController.amount) -
            int.parse(finalProduct.selectedAmount))
        .toString());
    resetFormFields();
    modifyProductMapQuantity(finalProduct, _productController.amount);
  }

  @computed
  double get valueSalesCart {
    if (amountSalesCartList == 0) return 0.00;
    double value = 0.00;
    for (Product p in salesCartList) {
      value += (getProduct(p.name, categoryName: p.categoryName).price *
          int.parse(p.selectedAmount));
    }
    if (discount.contains("%")) {
      value -= (value * (int.parse(discount.split("%")[0]) / 100));
    } else {
      value -= double.parse(discount);
    }

    return value < 0 ? 0 : value;
  }

  Map<String, List<Product>> productMap;

  Salesman salesman;

  Salesman getFinalSalesman() {
    salesman = Salesman(
        comission: _salesmanController.salesmanComission ?? 0.0,
        name: _salesmanController.salesmanName ?? "Sem vendedor");
    salesman.clientName = clientName;
    return salesman;
  }

  @observable
  String _discount = "";

  @observable
  String _clientName = "";

  @observable
  String _amount = "";

  @computed
  String get discount {
    if (_discount == "") return "0.00";
    return _discount;
  }

  void setDiscountEditingController() {
    discountTextEditingController.text = _discount;
    discountTextEditingController.selection = TextSelection.collapsed(
        offset: discountTextEditingController.text.length);
  }

  void setDiscount(String text) {
    if (_discount.contains(".") && text.contains("%")) {
      setDiscountEditingController();
    } else if (_discount.contains("%") && text.contains(".")) {
      setDiscountEditingController();
    } else if (text.contains("%")) {
      if (text.split("%")[0].length == 0 ||
          text.split("%").length > 2 ||
          text.split("%")[1].length > 0)
        setDiscountEditingController();
      else
        _discount = text;
    } else if (text.contains(".")) {
      if (text.split(".")[0].length == 0 ||
          text.split(".").length > 2 ||
          text.split(".")[1].length > 2)
        setDiscountEditingController();
      else
        _discount = text;
    } else {
      _discount = text;
    }
  }

  @computed
  String get discountFormated {
    return !discount.toString().contains("%")
        ? "R\$ ${double.parse(discount).toStringAsFixed(2)}"
        : discount;
  }

  @computed
  String get amount => _amount;

  @computed
  bool get amountValidator => amount == null || amount.isEmpty;

  @action
  void setAmount(String amount) {
    _amount = amount;
  }

  String amountError() {
    return amountValidator ? "Obrigatório!" : null;
  }

  @computed
  String get clientName => _clientName;

  @computed
  bool get clientNameValidator => clientName.isEmpty;

  @action
  void setClientName(String name) {
    _clientName = name;
  }

  String clientNameError() {
    return clientNameValidator ? "Campo obrigatório!" : null;
  }

  @observable
  SalemanController _salesmanController = SalemanController();

  @computed
  SalemanController get salesmanController => _salesmanController;

  @observable
  ProductController _productController = ProductController();

  @computed
  ProductController get product => _productController;

  void resetFormFields() {
    // if (!product.amountIsNotNull) {
    //   clientNameTextEditingController.clear();
    //   _clientName = "";
    // }
    amountTextEditingController.clear();
    _amount = "";
  }

  @action
  void setCategoryName(String categoryProduct) {
    _productController.changeProductSale(productMap[categoryProduct].first);
    resetFormFields();
  }

  @action
  void setProductName(String productName) {
    if (productName == "Vazio") return;

    for (Product p in productMap[_productController.categoryName]) {
      if (p.name == productName) {
        _productController.changeProductSale(p);
        break;
      }
    }

    //print(_productController.productName);
    resetFormFields();
  }

  @action
  void setSize(String size) {
    if (size == "Vazio") return;
    _productController.setSize(
        size, getProduct(_productController.productName));
    resetFormFields();
  }

  @action
  void setColor(String color) {
    if (color == "Vazio") return;
    _productController.setColor(
        color, getProduct(_productController.productName));

    resetFormFields();
  }

  Product getProduct(String productName, {String categoryName}) {
    Product prod;

    for (Product p
        in productMap[categoryName ?? _productController.categoryName]) {
      if (p.name == productName) {
        prod = p;
      }
    }

    return prod;
  }

  List<String> getListColors() {
    Product p = getProduct(_productController.productName);

    if (p == null || _productController.color == null) {
      return ["Vazio"];
    }
    return p.features[_productController.size].keys.toList();
  }

  void setSelectedAmount(String text) {
    //setAmount(text);
    if (int.parse(text) > int.parse(product.amount)) {
      amountTextEditingController.text = product.amount;
    } else if (int.parse(text) <= 0) {
      amountTextEditingController.value = TextEditingValue(text: "1");
    }
    setAmount(amountTextEditingController.text);

    print(amountTextEditingController.text);
    amountTextEditingController.selection = TextSelection.collapsed(
        offset: amountTextEditingController.text.length);
  }

  Salesman getSalesman(String text) {
    Salesman salesman;
    for (Salesman s in listSalesman) {
      if (s.name == text) {
        salesman = s;
        break;
      }
    }

    return salesman;
  }

  void setSalesman(String name) {
    salesmanController.setSalesman(getSalesman(name));
  }

/*  @computed
  bool get enableButton => !(amountTextEditingController.text.isEmpty ||
        clientName.isEmpty ||
        _salesmanController.salesmanName.isEmpty ||
        product.color.isEmpty ||
        product.size.isEmpty ||
        product.productName.isEmpty ||
        product.categoryName.isEmpty);*/

  @computed
  bool get enableCheckButton =>
      !(clientNameValidator || amountSalesCartList == 0);

  @computed
  bool get enableButtonAddList => !amountValidator;

  Product getFinalProduct() {
    Product product = Product();

    product.categoryId =
        productMap[_productController.categoryName][0].categoryId;
    product.categoryName = _productController.categoryName;
    product.name = _productController.productName;
    product.selectedSize = _productController.size;
    product.selectedColor = _productController.color;
    product.selectedAmount = amountTextEditingController.text;
    // product.clientName = clientName;
    product.price = getProduct(_productController.productName).price;

    // product.salesman = (Salesman(
    //     comission: _salesmanController.salesmanComission ?? 0.0,
    //     name: _salesmanController.salesmanName ?? "Sem vendedor"));
    // product.salesman.clientName = clientName;

    // print(product.categoryId);
    // print(product.categoryName);
    // print(product.name);
    // print(product.selectedSize);
    // print(product.selectedColor);
    // print(product.salesman.name);
    // print(product.salesman.comission);
    // print(product.clientName);
    // print(product.selectedAmount);

    return product;
  }

  List getFinalSalesCartList() {
    List<Map> list = List();
    for (Product p in salesCartList) {
      list.add(p.soldToJson());
    }

    return list;
  }

  void disposeAll() {
    amountTextEditingController.dispose();
    clientNameTextEditingController.dispose();
    discountTextEditingController.dispose();
  }
}
