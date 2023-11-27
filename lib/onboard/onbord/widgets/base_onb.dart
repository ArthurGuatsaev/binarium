// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/onboard/onbord/widgets/indicator.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VBaseBoard extends StatelessWidget {
  final VBoardParam boardParam;
  const VBaseBoard({
    Key? key,
    required this.boardParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              boardParam.image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 60),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) =>
                            previous.onboardIndex != current.onboardIndex,
                        builder: (context, state) {
                          return MyCheckBox(
                            index: state.onboardIndex,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        boardParam.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        boardParam.body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: boardParam.buttonText,
                            function: boardParam.function,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
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

class VBoardParam {
  final String? tg;
  final String image;
  final String title;
  final String body;
  final String buttonText;
  final Function()? function;
  VBoardParam({
    this.tg,
    this.function,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonText,
  });
}
