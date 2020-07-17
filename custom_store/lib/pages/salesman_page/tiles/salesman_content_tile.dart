import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/crud_salesman_controller.dart';
import 'package:customstore/models/salesman.dart';
import 'package:customstore/pages/salesman_page/salesman_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SalesmanContentTile extends StatefulWidget {
  final DocumentSnapshot salesmanSnapshot;
  final CrudSalesmanController crudSalesmanController;
  final SalesmanController salesmanController;

  Salesman salesman = Salesman();

  SalesmanContentTile(
      {this.salesmanSnapshot,
      this.crudSalesmanController,
      this.salesmanController}) {
    salesman = salesman.fromMap(salesmanSnapshot);
  }

  @override
  _SalesmanContentTileState createState() => _SalesmanContentTileState();
}

class _SalesmanContentTileState extends State<SalesmanContentTile> {
  double radius;
  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    radius = 6.0;

    return Observer(
      builder: (context) => Slidable(
        controller: _slidableController,
        enabled: (!widget.salesmanController.isEditing &&
            !widget.crudSalesmanController.isLoading),
        actions: <Widget>[
          Container(
            decoration: getDecoration(
                color: Colors.blue,
                topLeft: radius,
                bottomLeft: radius,
                bottomRight: 0,
                topRight: 0),
            margin: const EdgeInsets.only(top: 8, left: 14, bottom: 8),
            child: IconSlideAction(
              caption: 'Editar',
              color: Colors.transparent,
              icon: Icons.edit,
              onTap: () async {
                FocusScope.of(context).unfocus();
                await Future.delayed(Duration(milliseconds: 50));
                widget.salesmanController.setFields(
                    name: widget.salesman.name,
                    comission: widget.salesman.comission.toStringAsFixed(2),
                    documentID: widget.salesmanSnapshot.documentID);
                widget.salesmanController.isEditing = true;
                //widget.salesmanController.focusNode.requestFocus();
              },
            ),
          ),
          Container(
            decoration: getDecoration(
                color: Colors.red,
                topRight: radius,
                bottomRight: radius,
                bottomLeft: 0,
                topLeft: 0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: IconSlideAction(
              caption: 'Deletar',
              color: Colors.transparent,
              icon: Icons.delete,
              onTap: () {
                Salesman currentSalesman =
                    Salesman().fromMap(widget.salesmanSnapshot);

                widget.crudSalesmanController
                    .delete(documentID: widget.salesmanSnapshot.documentID);

                widget.salesmanController.scaffoldKey.currentState
                    .showSnackBar(widget.salesmanController.getSnackBar(
                        message: "DELETADO com sucesso!",
                        snackBarAction: SnackBarAction(
                          label: "DESFAZER",
                          textColor: Colors.red,
                          onPressed: () {
                            widget.crudSalesmanController.insert(
                                categoryName: currentSalesman.name,
                                comission: currentSalesman.comission
                                    .toStringAsFixed(2));
                          },
                        )));
              },
            ),
          ),
        ],
        actionPane: SlidableBehindActionPane(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: getDecoration(
              color: (!widget.salesmanController.isEditing &&
                          !widget.crudSalesmanController.isLoading) ||
                      widget.salesmanController.editedDocumentId ==
                          widget.salesmanSnapshot.documentID
                  ? Colors.white
                  : Colors.grey[500]),
          child: ListTile(
              title: Text(widget.salesman.name),
              subtitle: Text(
                  "Comissão: ${widget.salesman.comission.toStringAsFixed(2)}"),
              trailing: Container(
                child: Image.asset("assets/swipe_right.png"),
                height: 40,
                width: 40,
              )),
        ),
      ),
    );
  }

  BoxDecoration getDecoration(
      {Color color,
      double topLeft,
      double topRight,
      double bottomLeft,
      double bottomRight}) {
    return BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft ?? radius),
            bottomLeft: Radius.circular(bottomLeft ?? this.radius),
            topRight: Radius.circular(topRight ?? this.radius),
            bottomRight: Radius.circular(
                bottomRight ?? this.radius)) /*BorderRadius.circular(8)*/,
        color: color ?? Colors.transparent,
        border: color == Colors.white ? Border.all(width: 0) : null);
  }
}
