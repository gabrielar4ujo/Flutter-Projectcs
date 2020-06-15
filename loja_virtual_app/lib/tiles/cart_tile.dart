import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/datas/cart_product.dart';
import 'package:loja_virtual_app/datas/product_data.dart';
import 'package:loja_virtual_app/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  Widget _buildContent(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          height: 120,
          child: Image.network(
            cartProduct.productData.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  cartProduct.productData.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                  ),
                ),
                Text(
                  "Tamanho: ${cartProduct.size}",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: cartProduct.quantity > 1 ? (){
                        print("Diminuir");
                        CartModel.of(context).decProduct(cartProduct);
                      } : null,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(cartProduct.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add,  color: Theme.of(context).primaryColor,),
                      onPressed: (){
                        CartModel.of(context).incProduct(cartProduct);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Remover",
                      ),
                      textColor: Colors.grey[500],
                      onPressed: (){
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("products").document(cartProduct.category).collection("items").document(cartProduct.pid).get(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data);
            return _buildContent(context);
          }
          else{
            return Container(
              height: 70,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ):
      _buildContent(context),
    );
  }
}
