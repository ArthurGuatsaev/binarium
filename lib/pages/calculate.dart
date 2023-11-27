import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/const/strings.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatePage extends StatelessWidget {
  const CalculatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/calc.png',
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.66,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('currency_converter',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w300))
                            .tr(),
                      ),
                    ),
                    const ValuteList(),
                    const FromToWidget(),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CalcButton(
                        text: 'trade_this',
                        function: MyNavigatorManager.instance.simulatorPush,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FromToWidget extends StatefulWidget {
  const FromToWidget({
    super.key,
  });

  @override
  State<FromToWidget> createState() => _FromToWidgetState();
}

class _FromToWidgetState extends State<FromToWidget> {
  late final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => context.read<HomeBloc>().add(ChangeViewAllEvent()),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child:
                    const Text('view_all', style: TextStyle(color: gradColor))
                        .tr(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('from'.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium)
              .tr(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: calculItemColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: BlocConsumer<TradeBloc, TradeState>(
                    listenWhen: (previous, current) {
                      return previous.priceModel.currentValute !=
                          current.priceModel.currentValute;
                    },
                    listener: (context, state) {
                      controller.clear();
                    },
                    buildWhen: (previous, current) {
                      return previous.priceModel.currentValute !=
                          current.priceModel.currentValute;
                    },
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              context.read<TradeBloc>().add(
                                  CalculateValuteEvent(
                                      value: double.tryParse(value)));
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                hintText: 'enter_amount'.tr()),
                          )),
                          Text(state.priceModel.fromValute,
                              style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(width: 5),
                          fromToFlags[state.priceModel.fromValute] ??
                              const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('to'.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium)
              .tr(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: calculItemColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: BlocBuilder<TradeBloc, TradeState>(
                    buildWhen: (previous, current) =>
                        previous.priceModel.currentValute !=
                        current.priceModel.currentValute,
                    builder: (context, state) {
                      return Row(
                        children: [
                          BlocBuilder<TradeBloc, TradeState>(
                            buildWhen: (previous, current) =>
                                previous.calculateData.calcResult !=
                                current.calculateData.calcResult,
                            builder: (context, state) {
                              return Expanded(
                                child: state.calculateData.calcResult == 0
                                    ? Text('calculation_result',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall)
                                        .tr()
                                    : Text(
                                        '${state.calculateData.calcResult}',
                                      ),
                              );
                            },
                          ),
                          Text(state.priceModel.toValute,
                              style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(width: 5),
                          fromToFlags[state.priceModel.toValute] ??
                              const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ValuteList extends StatefulWidget {
  const ValuteList({
    super.key,
  });

  @override
  State<ValuteList> createState() => _ValuteListState();
}

class _ValuteListState extends State<ValuteList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.viewAll != current.viewAll,
      builder: (context, state) {
        return BlocBuilder<TradeBloc, TradeState>(
          buildWhen: (previous, current) =>
              previous.calculateData.valuteList !=
              current.calculateData.valuteList,
          builder: (context, stateV) {
            return SliverList.builder(
              itemCount:
                  state.viewAll ? stateV.calculateData.valuteList.length : 3,
              itemBuilder: (context, index) {
                final currentV = stateV.calculateData.valuteList[index];
                final currentK =
                    '${currentV.substring(0, 3)}/${currentV.substring(3, 6)}';
                return GestureDetector(
                  onTap: () => context
                      .read<TradeBloc>()
                      .add(ChangeCurrentValute(currentValute: currentV)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ColoredBox(
                        color: calculItemColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    flags[currentV] ??
                                        const SizedBox(
                                          width: 30,
                                        ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(currentK,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                    GestureDetector(
                                        onTap: () => context
                                            .read<TradeBloc>()
                                            .add(
                                                ChangeValuteList(index: index)),
                                        child: stateV.calculateData
                                                    .favoriteValute !=
                                                stateV.calculateData
                                                    .valuteList[index]
                                            ? const SizedBox(
                                                width: 30,
                                                child: Center(
                                                    child: Icon(
                                                        Icons.turned_in_not)))
                                            : SizedBox(
                                                width: 30,
                                                child: Center(
                                                  child: Image.asset(
                                                      'assets/images/shevron.png'),
                                                ),
                                              ))
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    BlocBuilder<TradeBloc, TradeState>(
                                      buildWhen: (previous, current) =>
                                          previous.priceModel.currentValute !=
                                          current.priceModel.currentValute,
                                      builder: (context, state) {
                                        return SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: state.priceModel
                                                          .currentValute !=
                                                      currentV
                                                  ? const SizedBox()
                                                  : const DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient: gradient)),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
