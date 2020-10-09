import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/core/calendary.dart';
import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  final Map salesMap;

  CustomListViewWidget({DocumentSnapshot salesList})
      : salesMap = salesList == null || salesList.data.isEmpty
            ? Map()
            : salesList.data;

  @override
  Widget build(BuildContext context) {
    // log(salesList[0].data.toString());
    // log(salesMap.length.toString());
    // log(salesMap["time"].toString());
    salesMap.remove("time");
    // log("removed");
    // log(salesMap.length.toString());
    // log(salesList[0].data.remove("time").toString());
    // log(salesList[0].data.length.toString());
    int index = -1;
    return ListView(
      children: salesMap.keys.map((e) {
        print(index);
        index++;
        return Card(
          margin: EdgeInsets.only(
              top: index == 0 ? 20 : 6,
              left: 12,
              right: 12,
              bottom: index == salesMap.length - 1 ? 20 : 6),
          child: ExpansionTile(
            title: Text(Calendary().getMonth(e)),
          ),
        );
      }).toList(),
    )
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: salesMap.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     //log(salesList.data[index].toString());
        //     return Card(
        //       margin: EdgeInsets.only(
        //           top: index == 0 ? 16 : 5,
        //           left: 12,
        //           right: 12,
        //           bottom: index == salesMap.length - 1 ? 16 : 5),
        //       child: ListTile(
        //         title: Text("oi"),
        //       ),
        //     );
        //   },
        // )
        ;
  }
}
