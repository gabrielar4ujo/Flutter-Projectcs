import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/product.dart';
import 'package:mobx/mobx.dart';

part 'category_controller.g.dart';

class CategoryController = _CategoryController with _$CategoryController;

abstract class _CategoryController with Store{

  final String category;
  final String uidUser;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Product> observableMap = ObservableList();

  @observable
  bool isExpanded = false;

  @action
  void onExpanded (bool b){
    isExpanded = b;
  }

  void loadDataProducts() async {
    isLoading = true;
    Firestore.instance.collection("stores").document(uidUser).collection("stock").document(category).snapshots().listen((event) {
      if(event.exists && event.data.containsKey("listProducts")){
        event.data["listProducts"].forEach( (k,v) {
          return observableMap.add( Product(name: k, price: double.parse(v["price"]), amount: int.parse(v["amount"]), categoryId: event.documentID, listPictures: v["pictures"], spent: double.parse(v["spent"])));
        });
      }
    });
    isLoading = false;
  }

  _CategoryController({this.uidUser, this.category}){
   loadDataProducts();
  }


}