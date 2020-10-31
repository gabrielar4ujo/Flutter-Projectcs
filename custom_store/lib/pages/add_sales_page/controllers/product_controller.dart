import 'package:customstore/models/product.dart';
import 'package:mobx/mobx.dart';

part 'product_controller.g.dart';

class ProductController = _ProductController with _$ProductController;

abstract class _ProductController with Store {
  Map<String, dynamic> colorMap;

  @observable
  String productName;

  @observable
  String size;

  @observable
  String color;

  @observable
  String amount;

  @computed
  bool get amountIsNotNullAndNotEmpty => amount != null && amount != "0";

  @observable
  String categoryName;

  @action
  void changeProductSale(Product product) {
    categoryName = product.categoryName;
    productName = product.name;

    setColorMap(product.features);
    setSize(
        colorMap != null && colorMap.isNotEmpty ? colorMap.keys.first : null,
        product);
  }

  void setColorMap(Map features) {
    if (productName != null) {
      colorMap = Map();

      features.forEach((key, value) {
        if (value.length > 0) {
          colorMap[key] = value;
        }
      });
    }
  }

  void setAmountWithProduct(Product p) {
    if (p.features != null && color != null) {
      amount = p.features[size][color]["amount"];
    } else
      amount = null;
  }

  void setColorWithProduct(Product p) {
    if (p.features != null && size != null && p.features[size].length > 0) {
      color = p.features[size].keys.first;
    } else
      color = null;
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

  void setAmount(String amount) {
    this.amount = amount;
  }

  _ProductController({this.productName, this.size, this.color, this.amount});
}
