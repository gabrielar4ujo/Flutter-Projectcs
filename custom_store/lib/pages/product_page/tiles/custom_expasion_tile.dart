import 'package:customstore/pages/product_page/tiles/add_color_tile.dart';
import 'package:customstore/pages/product_page/tiles/color_tile.dart';
import 'package:customstore/pages/product_page/widgets/alert_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomExpasionTile extends StatefulWidget {
  final String size;
  final Map featuresMap;
  final Function function;
  final Function removedFunction;

  CustomExpasionTile(
      {@required this.size,
      this.featuresMap,
      this.function,
      this.removedFunction});

  _CustomExpasionTileState createState() => _CustomExpasionTileState(
      size: size,
      featuresMap: featuresMap,
      function: function,
      removedFunction: removedFunction);
}

class _CustomExpasionTileState extends State<CustomExpasionTile> {
  final String size;
  final Map featuresMap;
  final Function function;
  final Function removedFunction;

  _CustomExpasionTileState(
      {this.removedFunction,
      this.function,
      this.featuresMap,
      @required this.size});

  @override
  void initState() {
    super.initState();
  }

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
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 5, right: 5),
            height: 60,
            child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                children: getListColorProductPage()
                    .map((e) => GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialogWidget(
                                    function: function,
                                    size: size,
                                    amount: e[1],
                                    colorName: e[0],
                                    removeFunction: removedFunction,
                                  ));
                        },
                        child: ColorTile(
                          amount: e[1],
                          colorName: e[0],
                        )))
                    .toList()
                      ..insert(
                          0,
                          GestureDetector(
                            child: AddColorTile(),
                            onTap: () {
                              /*function(size: size, colorName: "Roxo", amount:"10");*/
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogWidget(
                                      function: function, size: size));
                            },
                          ))),
          )
        ],
      ),
    );
  }

  List getListColorProductPage() {
    List listColorProductPage = List();
    print("FEATUIRESMAP: $featuresMap");
    if (featuresMap[size] == {}) return listColorProductPage;
    this.featuresMap.forEach((key, value) {
      listColorProductPage.add([key, value["amount"]]);
    });
    print("GETLISTPRODUCTPAGE");
    print(listColorProductPage);
    return listColorProductPage;
  }
}
