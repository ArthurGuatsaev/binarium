import 'package:binarium/const/colors.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/drop_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showMyTradePop(
    {required BuildContext context, required bool w}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          width: 300,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: Text('enter_trading_info',
                              maxLines: 1,
                              textAlign: TextAlign.center,
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
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 40,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: bottomNavColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: MyDropDownPriceWidget(),
                            )),
                      )),
                  const SizedBox(width: 5),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: bottomNavColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            child: MyDropDownTimeWidget(),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CalcButton(
                    function: () {
                      context.read<TradeBloc>().add(AddOrderEvent(value: w));
                      MyNavigatorManager.instance.simulatorPop();
                    },
                    text: 'trade_this'),
              )
            ]),
          ),
        ),
      );
    },
  );
}
