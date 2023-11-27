import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistroryEpty extends StatelessWidget {
  final bool isA;
  const HistroryEpty({super.key, required this.isA});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width),
        isA
            ? const Text(
                'empty_active',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ).tr()
            : const Text(
                'empty_disactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ).tr(),
        const SizedBox(height: 40),
        isA
            ? Image.asset('assets/images/grossy.png')
            : Image.asset('assets/images/glossy.png')
      ],
    );
  }
}
