import 'package:customstore/models/product.dart';
import 'package:mobx/mobx.dart';

part 'product_controller.g.dart';

class ProductController = _ProductController
    with _$ProductController;

abstract class _ProductController with Store {
  @observable
  String productName;

  @observable
  String size;

  @observable
  String color;

  @observable
  String amount;

  @computed
  bool get amountIsNotNull => amount != null;

  @observable
  String categoryName;

  @action
  void changeProductSale(Product product) {
    categoryName = product.categoryName;
    productName = product.name;
    size = product.name == null ? null : product.selectedSize;

    setColorWithProduct(product);
    setAmountWithProduct(product);
  }

  void setAmountWithProduct(Product p) {
    if (p.features != null && color != null) {
      amount = p.features[size][color]["amount"];
    } else
      amount = null;

    print("Amount: $amount");
  }

  void setColorWithProduct(Product p) {
    if (p.features != null && size != null && p.features[size].length > 0) {
      color = p.features[size].keys.first;
    } else
      color = null;

    print("Color: $color");
  }

  void setSize(String size, Product p) {
    this.size = size;
    setColorWithProduct(p);
    setAmountWithProduct(p);
  }

  void setColor(String color, Product p) {
    this.color = color;
    setAmountWithProduct(p);
  }

  _ProductController(
      {this.productName, this.size, this.color, this.amount});
}
