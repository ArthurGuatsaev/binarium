import 'package:binarium/const/colors.dart';
import 'package:flutter/material.dart';

class VTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final TextInputAction? inputAction;
  const VTextField({
    required this.controller,
    required this.hint,
    this.maxLines,
    this.inputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bottomNavColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: SizedBox(
          height: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: calculItemColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: inputAction ?? TextInputAction.done,
                  controller: controller,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: hintColor,
                          fontWeight: FontWeight.w300),
                      hintText: hint,
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
