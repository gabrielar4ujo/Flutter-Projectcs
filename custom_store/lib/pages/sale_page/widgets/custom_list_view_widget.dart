import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  final List salesList;

  const CustomListViewWidget({this.salesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: salesList == null ? 0 : salesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(
              top: index == 0 ? 16 : 5,
              left: 12,
              right: 12,
              bottom: index == salesList.length - 1 ? 16 : 5),
          child: ListTile(
            title: Text(salesList[index]["time"].toDate().year.toString()),
          ),
        );
      },
    );
  }
}
