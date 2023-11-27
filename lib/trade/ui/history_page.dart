import 'package:binarium/const/colors.dart';
import 'package:binarium/const/strings.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/trade/ui/widgets/active_history.dart';
import 'package:binarium/trade/ui/widgets/finished_history.dart';
import 'package:binarium/widgets/page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeBloc, TradeState>(
      buildWhen: (previous, current) =>
          previous.activeOrders.values.length !=
              current.activeOrders.values.length ||
          previous.isActiveH != current.isActiveH,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bottomNavColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: PageViewContrButton(
                    isA: state.isActiveH,
                  ),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: state.isActiveH ? 0 : 1,
                children: [
                  ActiveHistory(
                    activeOrders: state.activeOrders,
                    isA: state.isActiveH,
                    valuteImage: flags,
                  ),
                  BlocBuilder<TradeBloc, TradeState>(
                    buildWhen: (previous, current) =>
                        previous.history.length != current.history.length,
                    builder: (context, history) {
                      final hist = history.history;
                      return DisactiveHistory(
                        history: hist,
                        isA: state.isActiveH,
                        valuteImage: flags,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class LeftTimer extends StatefulWidget {
  const LeftTimer({
    super.key,
    required this.order,
  });

  final MyOrder order;

  @override
  State<LeftTimer> createState() => _LeftTimerState();
}

class _LeftTimerState extends State<LeftTimer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.order.timerSubstruct(),
        builder: (context, snap) {
          if (!snap.hasData) return const SizedBox.shrink();
          return Text(
            snap.data ?? '00:00',
            style: const TextStyle(),
          );
        });
  }
}

extension Months on int {
  String get monthString {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'November';
    }
  }
}

extension MonthsNum on int {
  String get monthNum {
    switch (this) {
      case 1:
        return '01';
      case 2:
        return '02';
      case 3:
        return '03';
      case 4:
        return '04';
      case 5:
        return '05';
      case 6:
        return '06';
      case 7:
        return '07';
      case 8:
        return '08';
      case 9:
        return '09';
      case 2023:
        return '23';
      case 2024:
        return '24';
      default:
        return '$this';
    }
  }
}
