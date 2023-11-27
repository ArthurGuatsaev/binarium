import 'package:binarium/const/colors.dart';
import 'package:binarium/const/strings.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showWinPop(BuildContext context, MyOrder order) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        final isW = order.status == MyStatus.win;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 266,
            height: 299,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Result',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: calculItemColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: calculItemColor),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        flags[order.valute] ?? const SizedBox.shrink(),
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
                ),
                const SizedBox(height: 15),
                Container(
                  width: 139,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isW
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      '${isW ? '+' : '-'}${order.price} \$',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isW ? Colors.green : Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  isW
                      ? 'You made money on this deal.'
                      : 'You lose on this trade.',
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: 139,
                    child: CalcButton(
                      text: 'Ok',
                      function: () =>
                          MyNavigatorManager.instance.simulatorPop(),
                    ))
              ],
            ),
          ),
        );
      });
}
