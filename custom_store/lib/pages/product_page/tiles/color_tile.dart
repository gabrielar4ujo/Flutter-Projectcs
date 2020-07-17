import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final String colorName;
  final String amount;
  final Color textColor;
  final Map<String, dynamic> features;
  ColorTile(
      {@required this.amount, @required this.colorName, this.features}) : textColor = colorName.toLowerCase() == "branco" ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: getColor(colorName), borderRadius: BorderRadius.circular(5),
        border: colorName.toLowerCase() == "branco" ? Border.all(width: 0) : null,
      ),
      height: 60,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            colorName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 12,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              "Qnt: $amount",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
       textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String colorName) {
    Color color;
    switch (colorName.toLowerCase()) {
      case "azul":
        color = Colors.blue;
        break;
      case "vermelho":
        color = Colors.red;
        break;
      case "preto":
        color = Colors.black;
        break;
      case "verde":
        color = Colors.green;
        break;
      case "roxo":
        color = Colors.purple;
        break;
      case "laranja":
        color = Colors.orange;
        break;
      case "branco":
        color = Colors.white;
        break;
      case "amarelo":
        color = Colors.yellow;
        break;
      case "marrom":
        color = Colors.brown;
        break;
      case "cinza":
        color = Colors.grey;
        break;
      case "rosa":
        color = Colors.pink;
        break;
      default:
        color = Colors.grey[400];
    }

    return color;
  }
}
