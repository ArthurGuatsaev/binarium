import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDropDownPriceWidget extends StatelessWidget {
  const MyDropDownPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: BlocBuilder<TradeBloc, TradeState>(
        builder: (context, state) {
          return DropdownButton<int>(
            hint: Text('enter_amount',
                    style: Theme.of(context).textTheme.displaySmall)
                .tr(),
            icon: const Icon(Icons.keyboard_arrow_down),
            value: state.priceModel.currentPrice == 0
                ? null
                : state.priceModel.currentPrice,
            borderRadius: BorderRadius.circular(10),
            isDense: true,
            isExpanded: true,
            focusColor: Colors.transparent,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text(
                  '-',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 50,
                child: Text(
                  '50 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 100,
                child: Text(
                  '100 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 200,
                child: Text(
                  '200 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 500,
                child: Text(
                  '500 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 1000,
                child: Text(
                  '1000 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 2000,
                child: Text(
                  '2000 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 5000,
                child: Text(
                  '5000 \$',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
            onChanged: (newValue) => {
              context
                  .read<TradeBloc>()
                  .add(ChangeCurrentPrice(currentPrice: newValue!))
            },
          );
        },
      ),
    );
  }
}

class MyDropDownTimeWidget extends StatelessWidget {
  const MyDropDownTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: BlocBuilder<TradeBloc, TradeState>(
        builder: (context, state) {
          return DropdownButton<int>(
            icon: const Icon(Icons.keyboard_arrow_down),
            hint: Text('enter_time',
                    style: Theme.of(context).textTheme.displaySmall)
                .tr(),
            value: state.priceModel.currentTime == 0
                ? null
                : state.priceModel.currentTime,
            borderRadius: BorderRadius.circular(10),
            isDense: true,
            isExpanded: true,
            focusColor: Colors.transparent,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text(
                  '-',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 30,
                child: Text(
                  '00:30',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 60,
                child: Text(
                  '01:00',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 90,
                child: Text(
                  '01:30',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 120,
                child: Text(
                  '02:00',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 180,
                child: Text(
                  '03:00',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              DropdownMenuItem(
                value: 300,
                child: Text(
                  '05:00',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
            onChanged: (newValue) => {
              context
                  .read<TradeBloc>()
                  .add(ChangeCurrentTime(currentTime: newValue!))
            },
          );
        },
      ),
    );
  }
}
