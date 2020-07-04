
import 'dart:io';
import 'dart:async';

import 'package:customstore/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'product_page_controller.g.dart';

class ProductPageController = _ProductPageController with _$ProductPageController;

abstract class _ProductPageController with Store {

  String categoryID;
  List allProductsName;

  _ProductPageController({Product product, this.categoryID, this.allProductsName}){
    if(product != null){
      _nameText = product.name;
      _priceText = product.price.toStringAsFixed(2);
      _spentText = product.spent.toStringAsFixed(2);
      _amount = product.amount;
      _pictureList.addAll(product.listPictures);
      allProductsName.remove(product.name);
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
  bool get duplicatedName =>  allProductsName.contains(nameText);

  @computed
  bool get nameValidator => nameText == null || nameText.isEmpty;

  @computed
  bool get emptyPriceValidator =>  priceText == null || priceText.isEmpty;

  @computed
  bool get invalidPriceValidator => double.tryParse(priceText) == null;

  @computed
  bool get invalidSpentValidator => double.tryParse(_spentText) == null;

  @action
  void changeName (String text) {
    _nameText = text;
  }

  @action
  void changePrice (String text) {
    _priceText = text;
  }

  @action
  void changeSpent (String text) {
    _spentText = text;
  }

  String onErrorProductText (){
    print("onErrorProductText");
    print(nameValidator);
    print(nameText);
    if(nameValidator) return "Este campo é obrigatório!";
    if(duplicatedName) return "Já existe um produto com esse nome!";

  }

  String onErrorPriceText (){
    if(emptyPriceValidator) return "Este campo é obrigatório!";

    else if(invalidPriceValidator) return "Valor inválido!";

    print(double.parse(priceText).toStringAsFixed(2));

    return null;
  }

  String onErrorSpentText(){
    return invalidSpentValidator ? "Valor inválido!" : null;
  }

  @observable
  int _amount = 1;

  @computed
  int get amount => _amount;

  @action
  void incrementOrDecrement(int number) {
    if (!(_amount <= 1) || number != -1) _amount += number;
  }

  @observable
  ObservableList<dynamic> _pictureList = ObservableList();

  @computed
  ObservableList get pictureList => _pictureList;

  @computed
  bool get stateIcon {
    print("ProductPageController: stateIcon");
    return !emptyPriceValidator && !invalidPriceValidator && !nameValidator && !duplicatedName;
  }

  Future openCamera () async{

    isLoading = true;

    final picker = ImagePicker();
    File imgFile;

    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 60);

    if(pickedFile == null) {
      isLoading = false;
    }

    imgFile = File(pickedFile.path);

    _pictureList.insert(0,imgFile);

    isLoading = false;

  }

  Product getProduct(){
    return Product(name: _nameText, price: double.parse(_priceText), amount: _amount, listPictures: finalList, spent: double.parse(_spentText));
  }

  List getNewPictures (){
    List newPictures = List();
    pictureList.forEach((element) {
      if(element is File) newPictures.add(element);
    });

    return newPictures;
  }

/*  void finalizePictures (List e){
    finalList = e;
    _pictureList.forEach((element) {
      if (!(element is File)) {
        finalList.add(element);
        print("addiconaei");
      }
    });
    print("finalizePictures $finalList");
  }*/

  void addFinalListPicture(String e)  { finalList.add(e);}

  void finalizePictures (){
    _pictureList.forEach((element) {
      if (!(element is File)) {
        finalList.add(element);
        print("addiconaei");
      }
    });
    print("finalizePictures $finalList");
  }

  void removePictureFromList (var picture){
    _pictureList.remove(picture);
    if(picture is File) {
      print("Arquivo do celular");
      picture.delete();
    }

    else {
      removedPicturesUrl.add(picture);
      print("Arquivo no Firebase");
    }
  }


  List finalList = [];
  List removedPicturesUrl = List();

  @observable
  bool _lock = false;

  @computed
  bool get isLocked => _lock;

  @action
  void setLock( bool state){
    _setLock(state);
  }

  void _setLock(bool state) {_lock = state;}


}