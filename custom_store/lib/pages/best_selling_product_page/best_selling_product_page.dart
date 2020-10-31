import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class BestSellingProductPage extends StatelessWidget {
  final List medalImages = [
    "assets/gold_medal.svg",
    "assets/silver_medal.svg",
    "assets/bronze_medal.svg"
  ];

  final List colors = [
    Color.fromRGBO(255, 223, 0, .5),
    Color.fromRGBO(192, 192, 192, .9),
    Color.fromRGBO(205, 127, 50, .7),
  ];

  final String notExist = "NÃO EXISTE";

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Produto mais vendidos"),
      ),
      body: StreamBuilder(
        stream:
            GetIt.I.get<ControllerLoginPage>().getBestSellingProductSnapshot(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot == null || snapshot.hasError) {
            return Container(
              child: getWidgetText("Ocorreu algum erro x("),
            );
          }
          if (!snapshot.hasData) {
            return Container(
                child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ));
          }
          int lengthData = snapshot.data.documents.length;

          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                Map m;

                if (index < lengthData) {
                  m = snapshot.data.documents[index].data;
                } else {
                  m = null;
                }
                Product p = Product(
                    name: m == null ? notExist : m["productName"],
                    listPictures: m == null ? [null] : [m["urlPhoto"]],
                    price: m == null ? 0 : double.parse(m["price"]),
                    amount: m == null ? 0 : int.parse(m["counter"]))
                  ..categoryName = m == null ? notExist : m["categoryName"];
                return Center(
                  child: Card(
                    margin: EdgeInsets.only(
                        top: 30,
                        left: 45,
                        right: 45,
                        bottom: index == 2 ? 30 : 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: SvgPicture.asset(
                                medalImages[index],
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                child: ClipOval(
                                  child: FadeInImage(
                                    height: sizeWidth / 1.615,
                                    width: sizeWidth / 1.615,
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                    image: p.listPictures.first == null
                                        ? AssetImage(
                                            "assets/star.png",
                                          )
                                        : NetworkImageWithRetry(
                                            p.listPictures.first,
                                          ),
                                    placeholder:
                                        AssetImage("assets/loading.gif"),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.all(12),
                                color: colors[index],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getWidgetText(
                                        "Categoria: ${p.categoryName}"),
                                    getWidgetText("Nome: ${p.name}"),
                                    getWidgetText(
                                        "Quantidade vendida: ${p.amount == 0 ? notExist : p.amount}"),
                                    getWidgetText(
                                        "Última venda desse produto: ${m == null ? notExist : DateFormat('dd/MM/yyyy').format(m["lastModified"].toDate()) + " às " + DateFormat('kk:mm').format(m["lastModified"].toDate())}"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget getWidgetText(String text) => Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
      );
}
