import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/models/product.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:get_it/get_it.dart';

class ContentListViewWidget extends StatelessWidget {
  final fontSize = 14.5;
  final Product product;
  final Salesman salesman;

  ContentListViewWidget({@required this.product, @required this.salesman});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                child: FutureBuilder(
                  future: GetIt.I
                      .get<ControllerLoginPage>()
                      .getFutureCategorySnapshot()
                      .then((value) {
                    for (DocumentSnapshot documentSnapshot in value.documents) {
                      Map m = documentSnapshot.data["listProducts"];
                      if (m.containsKey(product.name))
                        return m[product.name]["pictures"];
                    }
                    return [];
                  }),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Image.asset(
                        "assets/loading.gif",
                        fit: BoxFit.cover,
                      );
                    } else if (snapshot.data.length == 0) {
                      return Image.asset(
                        "assets/roupa.jpg",
                        fit: BoxFit.cover,
                      );
                    }
                    return FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImageWithRetry(snapshot.data.first),
                      placeholder: AssetImage("assets/loading.gif"),
                    );
                  },
                ),
                width: 130,
                height: 145,
              )),
          Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: 145,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Categoria: ${product.categoryName}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Produto: ${product.name}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Preço: R\$ ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Custo: R\$ ${product.spent.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Quantidade: ${product.selectedAmount}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Tamanho: ${product.selectedSize}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        "Cor: ${product.selectedColor}",
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
