import 'package:flutter/material.dart';
import 'package:pokeflutter/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final Widget image;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.image, this.types})
      : super(key: key);

  Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            //setTipos(),
            Align(
                alignment: Alignment.bottomRight,
                child: Opacity(opacity: .2,child: Image.asset(ConstApp.whitePokeball, height: 80,width: 80,))),
            Align(
                alignment: Alignment.bottomRight,
                child: image,
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 5,),
                  setTipos(),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: ConstApp.getColorType(type: types[0]), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
