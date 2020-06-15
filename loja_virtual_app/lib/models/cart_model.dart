
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_app/datas/cart_product.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;

  List<CartProduct> products = List();

  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user){
    if(user.isLoggedIn()) _loadCartItems();
  }

  bool isLoading = false;

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    /*Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments().then( (doc) {
      CartProduct cartProduct = CartProduct.fromDocument(doc.documents[0]);
      products.add(CartModel)
    });*/
  }

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then(
        (doc){
          cartProduct.cid = doc.documentID;
        }
    );

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();
  }


  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async{

    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();

    products = querySnapshot.documents.map( (doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();

  }

  void setCoupon(String couponCode , int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }
}