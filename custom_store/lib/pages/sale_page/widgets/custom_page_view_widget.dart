import 'package:customstore/pages/sale_page/controllers/sale_page_controller.dart';
import 'package:customstore/pages/sale_page/widgets/custom_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

class CustomPageViewWidget extends StatelessWidget {
  final List salesList;
  final InfinityPageController _infinityPageController =
      InfinityPageController();
  final SalesPageController salesPageController;

  CustomPageViewWidget({this.salesList, @required this.salesPageController});

  @override
  Widget build(BuildContext context) {
    return InfinityPageView(
        controller: _infinityPageController,
        itemCount: salesList.length,
        itemBuilder: (context, index) {
          return ListView(
            //physics: NeverScrollableScrollPhysics(),
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 20, left: 16),
                child: Text(
                  "Vendas de ${salesList[index].data["time"].toDate().year.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              CustomListViewWidget(
                salesPageController: salesPageController,
                salesMap: salesList[index].data,
                documentID: salesList[index].documentID,
              ),
              Container(
                height: 85,
              )
            ],
          );
        });
  }
}
