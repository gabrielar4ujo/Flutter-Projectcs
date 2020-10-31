import 'package:flutter/material.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

class ContentPageViewWidget extends StatelessWidget {
  final InfinityPageController infinityPageController;
  final String year;
  final String more;
  final String less;
  final double gain;
  final double average;

  const ContentPageViewWidget(
      {this.infinityPageController,
      this.year,
      this.more,
      this.less,
      this.gain,
      this.average});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      infinityPageController.jumpToPage(
                        infinityPageController.page - 1,
                      );
                    }),
                Text(
                  year,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                    ),
                    onPressed: () {
                      infinityPageController.jumpToPage(
                        infinityPageController.page + 1,
                      );
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 52,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lucro total: R\$ ${gain.toStringAsFixed(2)}"),
                  Text("Mês com maior lucro: $more"),
                  Text("Mês com menor lucro: $less"),
                  Text(
                      "Média de todos os meses: R\$ ${average.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        )
        // Center(
        //   child: Text(
        //       "AQUI VAI FICAR OS DADOS DE ${DateTime.now().year + index}"),
        // ),

        );
  }
}
