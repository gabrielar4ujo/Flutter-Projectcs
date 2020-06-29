import 'dart:io';

import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/helpers/product_helper.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/image_controller.dart';
import 'package:customstore/pages/product_page/product_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductPage extends StatefulWidget {

  final Product product;
  final String categoryID;
  final List allProductsName;

  ProductPage({this.product, @required this.categoryID, this.allProductsName});

  @override
  _ProductPageState createState() => _ProductPageState(product: product,categoryID: categoryID, allProductsName: allProductsName);
}

class _ProductPageState extends State<ProductPage> {

  ProductHelper _productHelper;

  CrudProductController _crudProductController;

  double valueProgressIndicator = 0.0;
  bool showProgressBar = false;

  final Product product;
  final String categoryID;
  final List allProductsName;

  final ProductPageController _productPageController;

  _ProductPageState( {this.allProductsName,this.product, this.categoryID})  : _productPageController = ProductPageController(categoryID: categoryID, product: product, allProductsName: allProductsName);

  @override
  void initState() {
    super.initState();
    _crudProductController = CrudProductController();
    _productHelper = ProductHelper();
  }

  @override
  Widget build(BuildContext context) {

    String title = widget.product != null ? "Editar Produto" : "Criar Produto";

    return Scaffold(
      appBar: AppBar(
        bottom: showProgressBar ? _createProgressBar() : null,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            disabledColor: Colors.grey[500],
            onPressed: !(product == null) ? (){
            } : null,
          ),
          Observer(
            builder: (context) => IconButton(
              icon: Icon(Icons.check),
              disabledColor: Colors.grey[500],
              onPressed: _productPageController.stateIcon ? () async{
                for (String picture in _productPageController.removedPicturesUrl){
                  await _productHelper.deletePictures(picture);
                }

                List newPictures = _productPageController.getNewPictures();
                int lenght = newPictures.length;

                if(lenght > 0){
                /*  setState(() {
                    showProgressBar = true;
                  });*/
                  int count = 0;
                  for (File picture in newPictures){
                    print("+ 1 FILE");
                    await _crudProductController.savePictures(pictures: picture).then((value) => _productPageController.addFinalListPicture(value));
                    count++;
                 /*   setState(() {
                      valueProgressIndicator = count/lenght;
                    });*/
                  }
                  _productPageController.finalizePictures();
                }

/*
                await _crudProductController.savePictures(pictures: _productPageController.getNewPictures()).then((value) {
                  _productPageController.finalizePictures(value);
                });*/

                Navigator.pop(context, _productPageController.getProduct());
              } : null,
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[

         Observer(
           builder: (context) => Container(
             margin: EdgeInsets.only(bottom: 25),
             height: 120,
             child: ListView(
               padding: EdgeInsets.zero,
               scrollDirection: Axis.horizontal,
                 shrinkWrap: true,
               children: _productPageController.pictureList.map((e) {

                 ImageController _imageController = ImageController();

                 return GestureDetector(
                     child: Observer(
                       builder: (context) => Stack(children: <Widget>[
                         Container(height :120 ,width: 95, child: FadeInImage(placeholder: AssetImage("assets/loading.gif"), image: e is File ? FileImage(e) : NetworkImage(e), fit: BoxFit.cover,), margin: EdgeInsets.symmetric(horizontal: 2)),
                         _imageController.imageClick ? Container(child: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: (){
                           print("Remove Image Clicked");
                        _productPageController.removePictureFromList(e);
                         },), alignment: Alignment.topRight, height: 120, width: 95,) : Container()
                         ,
                       ],),
                     ),
                   onTap: _imageController.imageCliked,
                 );
               }).toList()..add(
                 GestureDetector(
                     child: Container(color: Colors.black.withOpacity(.4), margin: EdgeInsets.symmetric(horizontal: 2),height: 120, width: 95, child: Center(child: Icon(Icons.photo_camera, size: 30, color: Colors.white,),),)
                 , onTap: _productPageController.openCamera,
                 )
               ),
             ),
           ),
         ),

          Observer(
            builder: (context) => Row(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: TextFormField(
                    initialValue: _productPageController.nameText,
                    textCapitalization: TextCapitalization.words,
                    onChanged: _productPageController.changeName,
                    decoration: InputDecoration(
                      errorText: _productPageController.onErrorProductText(),
                      labelText: "Nome do produto"
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(padding: EdgeInsets.zero,icon: Icon(Icons.remove, color: Colors.deepPurpleAccent,), onPressed: (){
                        _productPageController.incrementOrDecrement(-1);
                      },),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(_productPageController.amount.toString()),
                      ),
                      IconButton(padding: EdgeInsets.zero, icon: Icon(Icons.add, color: Colors.deepPurpleAccent,), onPressed: (){
                        _productPageController.incrementOrDecrement(1);
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
          Observer(
            builder: (context) => Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    initialValue: _productPageController.priceText,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: _productPageController.changePrice,
                    decoration: InputDecoration(
                      errorText: _productPageController.onErrorPriceText(),
                        labelText: "Preço"
                    ),
                  ),
                  flex: 2,
                ),
                Spacer(flex: 1,),
                Flexible(
                  child: TextFormField(
                    initialValue: _productPageController.spentText,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: _productPageController.changeSpent,
                    decoration: InputDecoration(
                        labelText: "Gasto"
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      )
    );
  }

  PreferredSize _createProgressBar(){
    return PreferredSize(preferredSize: Size(double.infinity, 4.0),
      child: LinearProgressIndicator(
        value: valueProgressIndicator,
      ),);
  }
}
