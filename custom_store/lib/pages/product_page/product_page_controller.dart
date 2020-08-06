import 'dart:io';
import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:customstore/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'product_page_controller.g.dart';

class ProductPageController = _ProductPageController
    with _$ProductPageController;

abstract class _ProductPageController with Store {
  String categoryID;
  List allProductsName;

  final List listSizes = ["P", "G", "M", "GG", "XG", "U"];

  _ProductPageController(
      {Product product, this.categoryID, this.allProductsName}) {
    if (product != null) {
      _nameText = product.name;
      _priceText = product.price.toStringAsFixed(2);
      _spentText = product.spent.toStringAsFixed(2);
      _amount = product.amount;
      _pictureList.addAll(product.listPictures);
      allProductsName.remove(product.name);
      //observableFeatures.addAll(product.features);
    }

    for (String size in listSizes) {
      observableFeatures[size] = {};
      if (product != null &&
          product.features != null &&
          product.features.containsKey(size))
        product.features[size].forEach((k, v) {
          observableFeatures[size][k] = v;
        });
    }
  }

  @observable
  bool isLoading = false;

  @observable
  String _nameText = "";

  @observable
  String _priceText = "";

  @observable
  String _spentText = "0.00";

  @computed
  String get nameText => _nameText;

  @computed
  String get priceText => _priceText;

  @computed
  String get spentText => _spentText;

  @computed
  bool get duplicatedName => allProductsName.contains(nameText);

  @computed
  bool get nameValidator => nameText == null || nameText.isEmpty;

  @computed
  bool get emptyPriceValidator => priceText == null || priceText.isEmpty;

  @computed
  bool get invalidPriceValidator => double.tryParse(priceText) == null;

  @computed
  bool get invalidSpentValidator => double.tryParse(_spentText) == null;

  @action
  void changeName(String text) {
    _nameText = text;
  }

  @action
  void changePrice(String text) {
    _priceText = text;
  }

  @action
  void changeSpent(String text) {
    _spentText = text;
  }

  String onErrorProductText() {
    if (nameValidator) return "Campo obrigatório!";
    if (duplicatedName) return "Já existe um produto com esse nome!";
    return null;
  }

  String onErrorPriceText() {
    if (emptyPriceValidator)
      return "Campo obrigatório!";
    else if (invalidPriceValidator) return "Valor inválido!";

    return null;
  }

  String onErrorSpentText() {
    return invalidSpentValidator ? "Valor inválido!" : null;
  }

  @observable
  int _amount;

  @computed
  int get amount => _amount;

  /*@action
  void incrementOrDecrement(int number) {
    if (!(_amount <= 1) || number != -1) _amount += number;
  }*/

  @observable
  ObservableList<dynamic> _pictureList = ObservableList();

  @computed
  ObservableList get pictureList => _pictureList;

  @computed
  bool get stateIcon {
    return !emptyPriceValidator &&
        !invalidPriceValidator &&
        !nameValidator &&
        !duplicatedName;
  }

  Future openCamera() async {
    isLoading = true;

    final picker = ImagePicker();
    File imgFile;

    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 60);

    if (pickedFile == null) {
      isLoading = false;
    }

    imgFile = File(pickedFile.path);

    _pictureList.insert(0, imgFile);

    isLoading = false;
  }

  Product getProduct() {
    Product finalProduct = Product(
        name: _nameText,
        price: double.parse(_priceText),
        amount: _amount,
        listPictures: finalList,
        spent: double.parse(_spentText),
        features: getFeaturesMap());

    finalProduct.setAmount(featuresMap: finalProduct.features);
    return finalProduct;
  }

  List getNewPictures() {
    List newPictures = List();
    pictureList.forEach((element) {
      if (element is File) newPictures.add(element);
    });

    return newPictures;
  }

  void addFinalListPicture(String e) {
    finalList.add(e);
  }

  void finalizePictures() {
    _pictureList.forEach((element) {
      if (!(element is File)) {
        finalList.add(element);
      }
    });
  }

  void removePictureFromList(var picture) {
    _pictureList.remove(picture);
    if (picture is File) {
      picture.delete();
    } else {
      removedPicturesUrl.add(picture);
    }
  }

  List finalList = List();
  List removedPicturesUrl = List();

  @observable
  bool _lock = false;

  @computed
  bool get isLocked => _lock;

  @action
  void setLock(bool state) {
    _setLock(state);
  }

  void _setLock(bool state) {
    _lock = state;
  }

  @observable
  ObservableMap observableFeatures = ObservableMap();

  @action
  void setListColorProductPage(
      {String size, String colorName, String amount, String lastColorName}) {
    if (lastColorName != null && lastColorName != colorName) {
      removeColorFromList(color: lastColorName, size: size);
    }
    observableFeatures[size][colorName] = {"amount": amount};
    //else observableFeatures[size] = {colorName : {"amount" : amount}};
    observableFeatures = observableFeatures;
  }

  @action
  void removeColorFromList({String color, String size}) {
    observableFeatures[size].remove(color);
    observableFeatures = observableFeatures;
    /*observableFeatures.forEach((key, value) {
      if(color == key) {
        ob
      }
    })*/
  }

  List getListColorProductPage(String size) {
    List listColorProductPage = List();
    if (!observableFeatures.containsKey(size)) return listColorProductPage;
    this.observableFeatures[size].forEach((key, value) {
      listColorProductPage.add([StringUtils.capitalize(key), value["amount"]]);
    });

    return listColorProductPage;
  }

  Map<String, dynamic> getFeaturesMap() {
    Map<String, dynamic> m = Map<String, dynamic>();
    observableFeatures.forEach((key, value) {
      m[key] = value;
    });
    return m;
  }
}
