import 'package:customstore/pages/product_page/alert_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AlertDialogWidget extends StatelessWidget {
  final String size;
  final Function function;
  final String colorName;
  final String amount;
  final Function removeFunction;

  final AlertDialogController _alertDialogController;

  AlertDialogWidget(
      {Key key,
      @required this.size,
      @required this.function,
      this.colorName,
      this.amount,
      this.removeFunction})
      : _alertDialogController = AlertDialogController(
            amount: amount ?? "", colorName: colorName ?? "");

  // {
  //   _alertDialogController = AlertDialogController(amount: amount ?? "", colorName: colorName ?? "");
  // }

  @override
  Widget build(BuildContext context) {
    final bool editing = !(removeFunction == null);

    return AlertDialog(
      title: Text("Tamanho $size"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            initialValue: colorName ?? "",
            decoration: InputDecoration(labelText: "Cor"),
            onChanged: _alertDialogController.setColorName,
            textCapitalization: TextCapitalization.words,
          ),
          TextFormField(
            initialValue: amount ?? "",
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            decoration: InputDecoration(labelText: "Quantidade"),
            onChanged: _alertDialogController.setAmount,
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              editing
                  ? FlatButton(
                      child: Text(
                        "Remover",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        removeFunction(color: colorName, size: size);
                        Navigator.of(context).pop();
                      },
                    )
                  : Container(),
              Observer(
                  builder: (context) => FlatButton(
                        child: Text(
                          editing ? "Salvar" : "Adicionar",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        onPressed: _alertDialogController.enabledButton
                            ? () {
                                function(
                                    size: size,
                                    colorName: _alertDialogController.colorName,
                                    amount: _alertDialogController.amount,
                                    lastColorName: colorName);
                                Navigator.of(context).pop();
                              }
                            : null,
                      )),
            ],
          ),
        )
      ],
    );
  }
}
