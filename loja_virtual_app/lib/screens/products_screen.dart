import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/datas/cart_product.dart';
import 'package:loja_virtual_app/datas/product_data.dart';
import 'package:loja_virtual_app/models/cart_model.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:loja_virtual_app/screens/cart_screen.dart';
import 'package:loja_virtual_app/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  _ProductScreenState(this.product);

  String _size;

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            product.title
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: .9,
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,//Valor que determina valor do pontinho que fica na imagem
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: true, //Se definido como true (padrão), vai mudar de imagem automaticamente, pode setar duração com autoplayDuration,
              autoplayDuration: Duration(
                seconds: 5
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5
                    ),
                    children: product.sizes.map(
                        (s){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                _size = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  color: s == _size ? primaryColor : Colors.grey[500],
                                  width: 2
                                )
                              ),
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(
                                s
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: _size != null ? (){
                      if(UserModel.of(context).isLoggedIn()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = _size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;

                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()
                        ));
                      }
                      else{
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()
                        ));
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho" : "Entre ou Cadastre-se",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
