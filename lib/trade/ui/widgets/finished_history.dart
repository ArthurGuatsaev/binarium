import 'package:binarium/const/colors.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/trade/ui/history_page.dart';
import 'package:binarium/trade/ui/widgets/empty_history.dart';
import 'package:flutter/material.dart';

class DisactiveHistory extends StatelessWidget {
  final Map<String, Widget> valuteImage;
  final List<MyOrder> history;
  final bool isA;
  const DisactiveHistory(
      {super.key,
      required this.isA,
      required this.history,
      required this.valuteImage});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return HistroryEpty(
        isA: isA,
      );
    }
    return ListView.separated(
      itemCount: history.length,
      separatorBuilder: (context, index) {
        final orders = history;
        if (index == 0) return const SizedBox(height: 5);
        if (orders[index].date.day != orders[index - 1].date.day ||
            orders[index].date.month != orders[index - 1].date.month) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${orders[index].date.month.monthString}  ${orders[index].date.day}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return const SizedBox(
            height: 5,
          );
        }
      },
      itemBuilder: (context, index) {
        final order = history[index];
        final isWon = order.status == MyStatus.win;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '${history[index].date.month.monthString}  ${history[index].date.day}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ConstrainedBox(
              constraints: BoxConstraints.loose(
                  Size(MediaQuery.of(context).size.width, 100)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: calculItemColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    order.promise ? Colors.green : Colors.red),
                            child: Center(
                              child: order.promise
                                  ? const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          valuteImage[order.valute] ?? const SizedBox(),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            order.valute,
                            style: const TextStyle(color: Colors.black),
                          )),
                          Text(
                            '${isWon ? '+' : '-'}\$${order.price}',
                            style: TextStyle(
                                color: isWon ? Colors.green : Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Text(
                            'Invested:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' \$${order.price}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
