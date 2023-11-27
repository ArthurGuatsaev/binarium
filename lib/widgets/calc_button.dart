import 'package:binarium/const/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Function()? function;
  final String text;
  final Gradient? gradic;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CalcButton(
      {super.key,
      this.fontWeight,
      this.function,
      this.gradic,
      this.color,
      required this.text,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2250),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: gradic ?? gradient),
              child: Center(
                  child: Text(text,
                          style: TextStyle(
                              fontFamily: 'SF',
                              color: color ?? Colors.white,
                              fontSize: fontSize ?? 16,
                              fontWeight: fontWeight ?? FontWeight.w700))
                      .tr()),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: function,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          )
        ],
      ),
    );
  }
}
