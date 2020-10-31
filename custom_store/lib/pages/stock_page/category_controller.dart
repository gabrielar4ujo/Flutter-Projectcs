import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/product.dart';
import 'package:mobx/mobx.dart';

part 'category_controller.g.dart';

class CategoryController = _CategoryController with _$CategoryController;

abstract class _CategoryController with Store {
  final String category;
  final String uidUser;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Product> observableMap = ObservableList();

  void loadDataProducts() async {
    isLoading = true;
    Firestore.instance
        .collection("stores")
        .document(uidUser)
        .collection("stock")
        .document(category)
        .snapshots()
        .listen((event) {
      if (event.exists && event.data.containsKey("listProducts")) {
        event.data["listProducts"].forEach((k, v) {
          return observableMap.add(Product(
              name: k,
              price: double.parse(v["price"]),
              amount: getAmountFromProduct(v["features"]),
              categoryId: event.documentID,
              listPictures: v["pictures"],
              spent: double.parse(v["spent"]),
              features: v["features"]));
        });
      }
    });
    isLoading = false;
  }

  int getAmountFromProduct(Map features) {
    int amount = 0;
    features.forEach((key, value) {
      if (features[key].isNotEmpty) {
        for (Map m in features[key].values) {
          amount += int.parse(m["amount"]);
        }
      }
    });
    return amount;
  }

  _CategoryController({this.uidUser, this.category}) {
    loadDataProducts();
  }
}
