// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sales_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddSalesController on _AddSalesController, Store {
  Computed<double> _$valueSalesCartComputed;

  @override
  double get valueSalesCart =>
      (_$valueSalesCartComputed ??= Computed<double>(() => super.valueSalesCart,
              name: '_AddSalesController.valueSalesCart'))
          .value;
  Computed<String> _$discountComputed;

  @override
  String get discount =>
      (_$discountComputed ??= Computed<String>(() => super.discount,
              name: '_AddSalesController.discount'))
          .value;
  Computed<String> _$discountFormatedComputed;

  @override
  String get discountFormated => (_$discountFormatedComputed ??=
          Computed<String>(() => super.discountFormated,
              name: '_AddSalesController.discountFormated'))
      .value;
  Computed<String> _$amountComputed;

  @override
  String get amount =>
      (_$amountComputed ??= Computed<String>(() => super.amount,
              name: '_AddSalesController.amount'))
          .value;
  Computed<bool> _$amountValidatorComputed;

  @override
  bool get amountValidator =>
      (_$amountValidatorComputed ??= Computed<bool>(() => super.amountValidator,
              name: '_AddSalesController.amountValidator'))
          .value;
  Computed<String> _$clientNameComputed;

  @override
  String get clientName =>
      (_$clientNameComputed ??= Computed<String>(() => super.clientName,
              name: '_AddSalesController.clientName'))
          .value;
  Computed<bool> _$clientNameValidatorComputed;

  @override
  bool get clientNameValidator => (_$clientNameValidatorComputed ??=
          Computed<bool>(() => super.clientNameValidator,
              name: '_AddSalesController.clientNameValidator'))
      .value;
  Computed<SalemanController> _$salesmanControllerComputed;

  @override
  SalemanController get salesmanController => (_$salesmanControllerComputed ??=
          Computed<SalemanController>(() => super.salesmanController,
              name: '_AddSalesController.salesmanController'))
      .value;
  Computed<ProductController> _$productComputed;

  @override
  ProductController get product =>
      (_$productComputed ??= Computed<ProductController>(() => super.product,
              name: '_AddSalesController.product'))
          .value;
  Computed<bool> _$enableCheckButtonComputed;

  @override
  bool get enableCheckButton => (_$enableCheckButtonComputed ??= Computed<bool>(
          () => super.enableCheckButton,
          name: '_AddSalesController.enableCheckButton'))
      .value;
  Computed<bool> _$enableButtonAddListComputed;

  @override
  bool get enableButtonAddList => (_$enableButtonAddListComputed ??=
          Computed<bool>(() => super.enableButtonAddList,
              name: '_AddSalesController.enableButtonAddList'))
      .value;

  final _$amountSalesCartListAtom =
      Atom(name: '_AddSalesController.amountSalesCartList');

  @override
  int get amountSalesCartList {
    _$amountSalesCartListAtom.reportRead();
    return super.amountSalesCartList;
  }

  @override
  set amountSalesCartList(int value) {
    _$amountSalesCartListAtom.reportWrite(value, super.amountSalesCartList, () {
      super.amountSalesCartList = value;
    });
  }

  final _$_discountAtom = Atom(name: '_AddSalesController._discount');

  @override
  String get _discount {
    _$_discountAtom.reportRead();
    return super._discount;
  }

  @override
  set _discount(String value) {
    _$_discountAtom.reportWrite(value, super._discount, () {
      super._discount = value;
    });
  }

  final _$_clientNameAtom = Atom(name: '_AddSalesController._clientName');

  @override
  String get _clientName {
    _$_clientNameAtom.reportRead();
    return super._clientName;
  }

  @override
  set _clientName(String value) {
    _$_clientNameAtom.reportWrite(value, super._clientName, () {
      super._clientName = value;
    });
  }

  final _$_amountAtom = Atom(name: '_AddSalesController._amount');

  @override
  String get _amount {
    _$_amountAtom.reportRead();
    return super._amount;
  }

  @override
  set _amount(String value) {
    _$_amountAtom.reportWrite(value, super._amount, () {
      super._amount = value;
    });
  }

  final _$_salesmanControllerAtom =
      Atom(name: '_AddSalesController._salesmanController');

  @override
  SalemanController get _salesmanController {
    _$_salesmanControllerAtom.reportRead();
    return super._salesmanController;
  }

  @override
  set _salesmanController(SalemanController value) {
    _$_salesmanControllerAtom.reportWrite(value, super._salesmanController, () {
      super._salesmanController = value;
    });
  }

  final _$_productControllerAtom =
      Atom(name: '_AddSalesController._productController');

  @override
  ProductController get _productController {
    _$_productControllerAtom.reportRead();
    return super._productController;
  }

  @override
  set _productController(ProductController value) {
    _$_productControllerAtom.reportWrite(value, super._productController, () {
      super._productController = value;
    });
  }

  final _$_AddSalesControllerActionController =
      ActionController(name: '_AddSalesController');

  @override
  void setAmount(String amount) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setAmount');
    try {
      return super.setAmount(amount);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClientName(String name) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setClientName');
    try {
      return super.setClientName(name);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategoryName(String categoryProduct) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setCategoryName');
    try {
      return super.setCategoryName(categoryProduct);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProductName(String productName) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setProductName');
    try {
      return super.setProductName(productName);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSize(String size) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setSize');
    try {
      return super.setSize(size);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setColor(String color) {
    final _$actionInfo = _$_AddSalesControllerActionController.startAction(
        name: '_AddSalesController.setColor');
    try {
      return super.setColor(color);
    } finally {
      _$_AddSalesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
amountSalesCartList: ${amountSalesCartList},
valueSalesCart: ${valueSalesCart},
discount: ${discount},
discountFormated: ${discountFormated},
amount: ${amount},
amountValidator: ${amountValidator},
clientName: ${clientName},
clientNameValidator: ${clientNameValidator},
salesmanController: ${salesmanController},
product: ${product},
enableCheckButton: ${enableCheckButton},
enableButtonAddList: ${enableButtonAddList}
    ''';
  }
}
