import 'package:binarium/trade/ui/history_page.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<dynamic> showMyHistoryPop(BuildContext context) {
  return showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child);
    },
    pageBuilder: (context, _, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: Text('transaction_history',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge)
                            .tr()),
                    GestureDetector(
                      onTap: () {
                        MyNavigatorManager.instance.simulatorPop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.close,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Expanded(
                  child: SizedBox(
                    child: HistoryPage(),
                  ),
                )
              ]),
            ),
          ),
        ),
      );
    },
  );
}
