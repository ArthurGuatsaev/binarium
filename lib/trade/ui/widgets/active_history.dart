import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/trade/ui/widgets/empty_history.dart';
import 'package:binarium/widgets/timer.dart';
import 'package:flutter/material.dart';

const _itemBackground = Color(0xFFF2F2F2);

class ActiveHistory extends StatelessWidget {
  final Map<String, Widget> valuteImage;
  final Map<String, MyOrder> activeOrders;
  final bool isA;
  const ActiveHistory(
      {super.key,
      required this.activeOrders,
      required this.valuteImage,
      required this.isA});

  @override
  Widget build(BuildContext context) {
    if (activeOrders.values.isEmpty) {
      return HistroryEpty(
        isA: isA,
      );
    }
    return ListView.builder(
      itemCount: activeOrders.values.length,
      itemBuilder: (context, index) {
        final order = activeOrders.values.toList()[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.loose(
                    Size(MediaQuery.of(context).size.width, 100)),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: _itemBackground,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: order.promise
                                      ? Colors.green
                                      : Colors.red),
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
                              '\$${order.price}',
                              style: const TextStyle(color: Colors.black),
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
                              'Left:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            VTimer(duration: order.time, date: order.date),
                            const SizedBox(width: 3),
                            // LeftTimer(
                            //   key: ValueKey(order.myId),
                            //   order: order,
                            // ),
                            const Spacer(),
                            const Text(
                              'Deal time:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              order.dealTimeString,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
