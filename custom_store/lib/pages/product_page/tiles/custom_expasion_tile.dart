import 'package:basic_utils/basic_utils.dart';
import 'package:customstore/pages/product_page/product_page_controller.dart';
import 'package:customstore/pages/product_page/tiles/add_color_tile.dart';
import 'package:customstore/pages/product_page/tiles/color_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class CustomExpasionTile extends StatefulWidget {
  @override
  final String size;
  final Map featuresMap;
  final Function function;

  CustomExpasionTile(
      {@required this.size, this.featuresMap, this.function});

  _CustomExpasionTileState createState() => _CustomExpasionTileState(size: size,
      featuresMap: featuresMap,function: function);
}

class _CustomExpasionTileState extends State<CustomExpasionTile> {

  final String size;
  Map featuresMap;
  final Function function;

  _CustomExpasionTileState({this.function, this.featuresMap,
       @required this.size});

  @override
  Widget build(BuildContext context) {
    print("FEATURES");

    return Container(
      margin: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        /*borderRadius: BorderRadius.circular(15),*/
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.grey[100],
        title: Text(
          size,
          style: TextStyle(color: Colors.black),
        ),
        trailing: Icon(
          Icons.expand_more,
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 5, right: 5),
            height: 60,
            child:
                  ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      children:
                      getListColorProductPage()
                          .map((e) => GestureDetector(
                          child: ColorTile(amount: e[1], colorName: e[0],)))
                          .toList()
                        ..insert(0,GestureDetector(child: AddColorTile(), onTap:(){
                          function(size: size, colorName: "Roxo", amount:"10");
                        },))
                    /* <Widget>[
                  ColorTile(amount: 50,colorName: "AZUL"),
                  ColorTile(amount: 50,colorName: "VERDE"),
                  ColorTile(amount: 50,colorName: "BRANCO"),
                  ColorTile(amount: 50,colorName: "PRETO"),
                  ColorTile(amount: 50,colorName: "VERMELHO"),
                  ColorTile(amount: 50,colorName: "ESVERDEADO"),
                  ColorTile(amount: 50,colorName: "GALINHA"),
                  AddColorTile()
                ],*/
                  ),
          )
        ],
      ),
    );
  }

  List getListColorProductPage (){
    List listColorProductPage = List();
    print("FEATUIRESMAP: $featuresMap");
    if(featuresMap[size] == {}) return listColorProductPage;
    this.featuresMap.forEach((key, value) {
      listColorProductPage.add([StringUtils.capitalize(key),value["amount"]]);
    });
    print("GETLISTPRODUCTPAGE");
    print(listColorProductPage);
    return listColorProductPage;
  }
}
