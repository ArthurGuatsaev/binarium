import 'package:binarium/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../trade/domain/bloc/trade_bloc.dart';

class PageViewContrButton extends StatelessWidget {
  final bool isA;
  const PageViewContrButton({
    super.key,
    required this.isA,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: GestureDetector(
              onTap: () => context
                  .read<TradeBloc>()
                  .add(ChangeIsAHistoryEvent(isActiveH: true)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: isA
                      ? const CalcButton(
                          text: 'current',
                          fontSize: 14,
                          fontWeight: FontWeight.w500)
                      : const CalcButton(
                          text: 'current',
                          fontSize: 14,
                          gradic: _gradientTrandsparent,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                ),
              ),
            )),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: GestureDetector(
            onTap: () => context
                .read<TradeBloc>()
                .add(ChangeIsAHistoryEvent(isActiveH: false)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: SizedBox(
                child: !isA
                    ? const CalcButton(
                        text: 'closed',
                        fontSize: 14,
                        fontWeight: FontWeight.w500)
                    : const CalcButton(
                        text: 'closed',
                        fontSize: 14,
                        gradic: _gradientTrandsparent,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const _gradientTrandsparent = LinearGradient(colors: [
  Colors.transparent,
  Colors.transparent,
]);
