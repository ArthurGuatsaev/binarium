import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCheckBox extends StatelessWidget {
  final int index;
  const MyCheckBox({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 2; i++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<HomeBloc>()
                        .add(ChangeOnbIndicatorEvent(index: i));
                  },
                  child: SizedBox(
                    height: 8,
                    width: 85,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient:
                                index == i ? _gradient : _indicatorDisActive)),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
        ],
      ),
    );
  }
}

final _indicatorDisActive = LinearGradient(colors: [
  Colors.grey.withOpacity(0.3),
  Colors.grey.withOpacity(0.3),
]);
const _gradient = LinearGradient(colors: [
  Color(0xFF16CD8B),
  Color(0xFF3C89CF),
]);
