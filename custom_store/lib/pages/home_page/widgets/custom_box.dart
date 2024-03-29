import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomBox extends StatelessWidget {
  final String month;
  final String year;
  final String productName;
  final String salesmanName;
  final String productValue;
  final String clientName;
  final Function onTap;
  final bool obscure;
  final String sale;
  final String lastPurchase;
  final bool isExpasion;
  final Function changeYear;
  final List allYears;

  const CustomBox(
      {Key key,
      this.month,
      this.year,
      this.onTap,
      this.obscure,
      this.sale,
      this.lastPurchase,
      this.isExpasion,
      this.changeYear,
      this.productName,
      this.salesmanName,
      this.productValue,
      this.clientName,
      this.allYears})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textSize = 18.0;

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[800].withOpacity(0.5),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(0, -2))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3), topRight: Radius.circular(3))),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: month == null
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[100],
                  highlightColor: Colors.grey[700],
                  period: Duration(seconds: 2),
                  direction: ShimmerDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: 120,
                            color: Colors.black,
                          ),
                          Container(
                            height: 25,
                            width: 60,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: 90,
                            color: Colors.black,
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "SALDO DE ${month.toUpperCase()}",
                        style: TextStyle(fontSize: textSize),
                      ),
                      contentPadding: EdgeInsets.zero,
                      trailing: DropdownButton(
                        value: year,
                        items: (allYears == null || allYears.isEmpty
                                ? [DateTime.now().year.toString()]
                                : allYears)
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: textSize),
                                  ),
                                ))
                            .toList(),
                        onChanged: changeYear,
                      ),
                    ),
                    ListTile(
                      onTap: onTap,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        !obscure ? "R\$ $sale" : "R\$ *******",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: textSize),
                      ),
                      trailing: obscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ],
                ),
        ),
        Container(
          child: month == null
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[100],
                  highlightColor: Colors.grey[700],
                  period: Duration(seconds: 2),
                  direction: ShimmerDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 25,
                              width: 120,
                              color: Colors.black,
                              margin: EdgeInsets.symmetric(vertical: 12),
                            ),
                            Container(
                              height: 25,
                              width: 25,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : ExpansionTile(
                  initiallyExpanded: isExpasion,
                  title: Text(
                    "Ultima venda feita no valor de R\$ $lastPurchase",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  children: <Widget>[
                    Divider(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ultimo produto vendido",
                            style: TextStyle(
                                fontSize: 15.5, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  "Produto: $productName",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "Valor: R\$ $productValue",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  "Vendedor: $salesmanName",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "Cliente: $clientName",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[800].withOpacity(0.4),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 2.0, //exten// d the shadow
                    offset: Offset(0, 16))
              ],
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3))),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
        ),
      ],
    );
  }
}
