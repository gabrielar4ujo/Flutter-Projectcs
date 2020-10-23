import 'package:customstore/core/calendary.dart';
import 'package:customstore/core/crud_sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final Function function;
  final CrudSalesController crudSalesController;
  final String clientName;
  final DateTime dateTime;

  const CustomAlertDialogWidget({
    @required this.function,
    @required this.crudSalesController,
    this.clientName,
    this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Deseja remover a venda?"),
      content: Container(
        height: 55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //     "Alerta: A venda do cliente Luccas do dia 20 de Janeiro de 2020 será removido se continuar.")
            RichText(
              text: TextSpan(
                  text: 'Alerta: ',
                  children: <TextSpan>[
                    TextSpan(
                        text: "A venda do cliente ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: clientName,
                        style: TextStyle(color: Colors.deepPurple)),
                    TextSpan(
                        text: ' do dia ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: dateTime.day.toString(),
                        style: TextStyle(color: Colors.deepPurple)),
                    TextSpan(
                        text: ' de ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: Calendary().getMonth(dateTime.month.toString()),
                        style: TextStyle(color: Colors.deepPurple)),
                    TextSpan(
                        text: ' de ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: dateTime.year.toString(),
                        style: TextStyle(color: Colors.deepPurple)),
                    TextSpan(
                        text: ' será removida se continuar.',
                        style: TextStyle(color: Colors.black)),
                  ],
                  style: TextStyle(color: Colors.red, fontSize: 15.25)),
            ),
          ],
        ),
      ),
      buttonPadding: EdgeInsets.symmetric(horizontal: 16),
      actions: [
        Container(
          width: double.maxFinite,
          child: Observer(builder: (_) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    "Não",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  onTap: crudSalesController.isLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                ),
                GestureDetector(
                  child: Text(
                    "Sim",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                  ),
                  onTap: crudSalesController.isLoading ? null : function,
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
