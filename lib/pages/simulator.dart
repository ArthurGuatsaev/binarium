import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/trade/ui/widgets/pop_ap_hist.dart';
import 'package:binarium/widgets/pop_up/pop_up_trade.dart';
import 'package:binarium/widgets/trading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulatorPage extends StatefulWidget {
  static const String routeName = '/simulator';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SimulatorPage());
  }

  const SimulatorPage({super.key});

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  @override
  void initState() {
    context.read<TradeBloc>().add(GetHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/calc.png',
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
          BlocBuilder<TradeBloc, TradeState>(
            buildWhen: (previous, current) =>
                previous.isWorker != current.isWorker,
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => MyNavigatorManager.instance
                                        .simulatorPop(),
                                    child: const Icon(
                                      Icons.navigate_before_outlined,
                                      size: 40,
                                      weight: 0.5,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    state.priceModel.currentValute
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )),
                                  GestureDetector(
                                    onTap: () => showMyHistoryPop(context),
                                    child: const Icon(
                                      Icons.history,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  ChartsWidget(
                                    symbol: state.priceModel.currentValute,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 16,
                                      child:
                                          const ColoredBox(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SimulatorOrders(
                                      text: 'up',
                                      color: Colors.green,
                                      widget: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    SimulatorOrders(
                                      text: 'down',
                                      color: Colors.red,
                                      widget: Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SimulatorOrders extends StatelessWidget {
  const SimulatorOrders(
      {super.key,
      required this.color,
      required this.widget,
      required this.text});

  final Color color;
  final Widget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeBloc, TradeState>(
      // buildWhen: (previous, current) =>
      //     previous.order.time != current.order.time,
      builder: (context, state) {
        // final isA = state.order.time == '00:00';
        return Material(
          borderRadius: BorderRadius.circular(4),
          color: color,
          child: InkWell(
            onTap: () {
              showMyTradePop(context: context, w: text == 'up');
            },
            child: SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.47,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          text.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: widget,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
