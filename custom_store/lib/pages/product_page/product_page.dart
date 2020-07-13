import 'dart:io';

import 'package:customstore/core/crud_product_controller.dart';
import 'package:customstore/helpers/product_helper.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/product_page/finalize_product_controller.dart';
import 'package:customstore/pages/product_page/image_controller.dart';
import 'package:customstore/pages/product_page/product_page_controller.dart';
import 'package:customstore/pages/product_page/tiles/color_tile.dart';
import 'package:customstore/pages/product_page/tiles/custom_expasion_tile.dart';
import 'package:customstore/pages/product_page/widgets/custom_progress_bar_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final String categoryID;
  final List allProductsName;

  ProductPage({this.product, @required this.categoryID, this.allProductsName});

  @override
  _ProductPageState createState() => _ProductPageState(
      product: product,
      categoryID: categoryID,
      allProductsName: allProductsName);
}

class _ProductPageState extends State<ProductPage> {
  CrudProductController _crudProductController;

  final Product product;
  final String categoryID;
  final List allProductsName;

  final ProductPageController _productPageController;

  _ProductPageState({this.allProductsName, this.product, this.categoryID})
      : _productPageController = ProductPageController(
            categoryID: categoryID,
            product: product,
            allProductsName: allProductsName);

  @override
  void initState() {
    super.initState();
    _crudProductController = CrudProductController();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.product != null ? "Editar Produto" : "Criar Produto";

    print("PRODUCT");
    print(product.features["GG"]);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              disabledColor: Colors.white30,
              onPressed: !(product == null) && !_productPageController.isLoading
                  ? () async {
                      for (dynamic picture
                          in _productPageController.pictureList) {
                        if (picture is File)
                          await picture.delete();
                        else
                          await _crudProductController.deletePictures(picture);
                      }
                      Navigator.pop(context, Product());
                    }
                  : null,
            ),
            Observer(
              builder: (context) => IconButton(
                icon: Icon(Icons.check),
                disabledColor: Colors.white30,
                onPressed: _productPageController.stateIcon &&
                        !_productPageController.isLoading
                    ? () async {
                        for (String picture
                            in _productPageController.removedPicturesUrl) {
                          await _crudProductController.deletePictures(picture);
                        }

                        List newPictures =
                            _productPageController.getNewPictures();
                        if (newPictures.length > 0) {
                          FinalizeProductController finalizeProduct =
                              FinalizeProductController(
                                  length: newPictures.length);

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Observer(
                                        builder: (context) => WillPopScope(
                                              onWillPop: () =>
                                                  Future.value(false),
                                              child: CustomProgressBarWidgets(
                                                lenght: finalizeProduct.length,
                                                value: finalizeProduct.count,
                                                text: finalizeProduct.operation,
                                              ),
                                            )),
                                  ));

                          for (File picture in newPictures) {
                            await _crudProductController
                                .savePictures(pictures: picture)
                                .then((value) {
                              if (value != null) {
                                _productPageController
                                    .addFinalListPicture(value);
                                finalizeProduct
                                    .setOperetion("Salvando Imagens...");
                              } else
                                finalizeProduct.setOperetion("Error!\n"
                                    "Problema ao adicionar imagem: ${finalizeProduct.count + 1}");
                            });
                            finalizeProduct.increment();
                          }

                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pop(context);
                        }

                        _productPageController.finalizePictures();

                        Navigator.pop(
                            context, _productPageController.getProduct());
                      }
                    : null,
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
                        builder: (context) => Stack(
                          children: <Widget>[
                            Container(
                                height: 120,
                                width: 95,
                                child: FadeInImage(
                                  placeholder: AssetImage("assets/loading.gif"),
                                  image: e is File
                                      ? FileImage(e)
                                      : NetworkImage(e),
                                  fit: BoxFit.cover,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2)),
                            _imageController.imageClick
                                ? Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        print("Remove Image Clicked");
                                        _productPageController
                                            .removePictureFromList(e);
                                      },
                                    ),
                                    alignment: Alignment.topRight,
                                    height: 120,
                                    width: 95,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      onTap: _imageController.imageCliked,
                    );
                  }).toList()
                    ..add(GestureDetector(
                      child: Container(
                        color: Colors.black.withOpacity(.4),
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 120,
                        width: 95,
                        child: Center(
                          child: Icon(
                            Icons.photo_camera,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: !_productPageController.isLoading
                          ? _productPageController.openCamera
                          : null,
                    )),
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
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: _productPageController.changeName,
                      decoration: InputDecoration(
                          errorText:
                              _productPageController.onErrorProductText(),
                          labelText: "Nome do produto"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.remove,
                            color: Colors.deepPurpleAccent,
                          ),
                          onPressed: () {
                            _productPageController.incrementOrDecrement(-1);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(_productPageController.amount.toString()),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.add,
                              color: Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              _productPageController.incrementOrDecrement(1);
                         /*     _productPageController.observableFeatures["GG"]
                                  ["arroz"] = {"amount": "20"};*/
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: _productPageController.changePrice,
                      decoration: InputDecoration(
                          errorText: _productPageController.onErrorPriceText(),
                          labelText: "Preço"),
                    ),
                    flex: 2,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: _productPageController.spentText,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: _productPageController.changeSpent,
                      decoration: InputDecoration(
                          errorText: _productPageController.onErrorSpentText(),
                          labelText: "Gasto"),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Observer(
                builder: (context) => CustomExpasionTile(
                    size: "P",
                    function: _productPageController.setListColorProductPage,
                    featuresMap:
                        _productPageController.observableFeatures["P"])),
            Observer(
                builder: (context) => CustomExpasionTile(
                  size: "M",
                  function: _productPageController.setListColorProductPage,
                  featuresMap:
                  _productPageController.observableFeatures["M"])),
            Observer(
                builder: (context) => CustomExpasionTile(
                  size: "G",
                  function: _productPageController.setListColorProductPage,
                  featuresMap:
                  _productPageController.observableFeatures["G"])),
            Observer(
                builder: (context) => CustomExpasionTile(
                  size: "GG",
                  function: _productPageController.setListColorProductPage,
                  featuresMap:
                  _productPageController.observableFeatures["GG"],)),
            Observer(
                builder: (context) => CustomExpasionTile(
                  size: "XG",
                  function: _productPageController.setListColorProductPage,
                  featuresMap:
                  _productPageController.observableFeatures["XG"])),
            Observer(
                builder: (context) => CustomExpasionTile(
                  size: "U",
                  function: _productPageController.setListColorProductPage,
                  featuresMap:
                  _productPageController.observableFeatures["U"])),

          ],
        ));
  }
}
