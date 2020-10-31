import 'package:customstore/core/calendary.dart';
import 'package:customstore/core/crud_sales_controller.dart';

import 'package:customstore/pages/sale_page/controllers/sale_page_controller.dart';
import 'package:customstore/pages/sale_page/widgets/custom_alert_dialog_widget.dart';
import 'package:customstore/pages/sale_page/widgets/custom_sale_page_animeted_wigdet.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';

class CustomListTileWidget extends StatelessWidget {
  final Map saleData;
  final DateTime dateTime;
  final SalesPageController salesPageController;
  final String salesMonth;
  final String documentID;
  final int index;

  CustomListTileWidget(
      {this.saleData,
      this.dateTime,
      @required this.salesPageController,
      @required this.salesMonth,
      @required this.documentID,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTileMoreCustomizable(
      title: Text(
        saleData["clientName"],
      ),
      subtitle: Text(
          "${Calendary().getMonth(dateTime.month.toString()).toString().substring(0, 3)} ${dateTime.day}, ${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().length > 1 ? dateTime.minute.toString() : '0' + dateTime.minute.toString()}"),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 40,
          height: 40,
          child: Icon(
            Icons.clear,
            color: Colors.redAccent,
          ),
        ),
        onTap: () async {
          CrudSalesController _crudSalesController = CrudSalesController();

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogWidget(
                    crudSalesController: _crudSalesController,
                    clientName: saleData["clientName"],
                    dateTime: saleData["time"].toDate(),
                    function: () async {
                      await _crudSalesController
                          .delete(
                              productList: saleData["productList"],
                              documentID: documentID,
                              month: salesMonth,
                              index: index)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                  ));
        },
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 18),
      horizontalTitleGap: 0.0,
      minVerticalPadding: 0.0,
      minLeadingWidth: 40.0,
      onTap: (details) {
        Navigator.of(context).push(_createRoute(saleData));
      },
      onLongPress: (details) {},
    );
  }

  Route _createRoute(Map saleData) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomSalePageAnimetedWidget(
        saleData: saleData,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
