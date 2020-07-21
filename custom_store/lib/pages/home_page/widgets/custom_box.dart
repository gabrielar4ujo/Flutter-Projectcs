import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final String month;
  final String year;
  final Function onTap;
  final bool obscure;
  final String sale;
  final String lastPurchase;
  final isExpasion;
  final Function changeYear;

  const CustomBox(
      {Key key,
      this.month,
      this.year,
      this.onTap,
      this.obscure,
      this.sale,
      this.lastPurchase, this.isExpasion, this.changeYear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textSize = 18.0;
    print(obscure);
    print("isExpasoon $isExpasion");
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
          child: Column(
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
                  items: ["2019","2020"].map((e) => DropdownMenuItem<String> (
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: textSize),
                    ),
                  )).toList(),
                  onChanged: changeYear,
                ),

                /* Text(
                  year,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: textSize),
                ),*/
              ),
              ListTile(
                onTap: onTap,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  !obscure ? "R\$ $sale" : "R\$ *******",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textSize),
                ),
                trailing: !obscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ],
          ),
        ),
        Container(
          //padding: EdgeInsets.only(left: 0),
          child: ExpansionTile(
            initiallyExpanded: isExpasion,
            title: Text(
              "Ultima venda feita no valor de R\$ $lastPurchase",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            trailing: isExpasion ? Icon(
              Icons.expand_less,
            ) : Icon(
              Icons.expand_more,),

            children: <Widget>[
              Divider(height: 5,)
              ,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Produto: Calcinha de renda",
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                        Flexible(
                          child: Text(
                              "Valor: R\$ 150.55",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Vendedor: Airla",
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                        Flexible(
                          child: Text(
                            "Cliente: Zefinha",
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
