// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binarium/auth/domain/bloc/auth/auth_bloc.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/widgets/calc_button.dart';

class LessonFinish extends StatelessWidget {
  final FinishData data;
  static const String routeName = '/lf';
  static Route route(FinishData data) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => LessonFinish(
              data: data,
            ));
  }

  const LessonFinish({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.lessonsItemIndex != current.lessonsItemIndex,
                builder: (context, state) {
                  return Row(
                    children: [
                      for (var i = 0; i <= (data.number ?? 5); i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SizedBox(
                              height: 8,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: data.isW
                                          ? Colors.green
                                          : Colors.red)),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.user != current.user,
                    builder: (context, state) {
                      return Text(
                        '${state.user.points}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      );
                    },
                  ),
                  const SizedBox(width: 3),
                  Text(data.isW ? ' +${data.bonus ?? 6}00' : '+0 ',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: gradColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const Text('\$',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                ],
              ),
              const SizedBox(height: 35),
              Text(
                data.isW ? 'lesson_successfully' : 'lesson_failed',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  color: data.isW ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ).tr(),
              const SizedBox(height: 35),
              SizedBox(
                height: 287,
                child: data.isW
                    ? Image.asset('assets/images/win.png')
                    : Image.asset('assets/images/lose.png'),
              ),
              const Spacer(),
              SizedBox(
                  child: Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: CalcButton(
                        text: 'exit',
                        function: () {
                          if (!data.isLesson) {
                            if (data.isW) {
                              context.read<TradeBloc>().add(
                                  BonusLessonPointsEvent(
                                      bonus: (data.bonus ?? 6) * 100));
                            }
                            context.read<HomeBloc>().add(RessetTestEvent());
                          } else {
                            context.read<TradeBloc>().add(
                                BonusLessonPointsEvent(
                                    bonus: (data.bonus ?? 6) * 100));
                          }
                          return MyNavigatorManager.instance.simulatorPop();
                        },
                        gradic: gradientD,
                        color: gradColor),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 48,
                    child: CalcButton(
                      text: data.isW
                          ? (data.isLesson
                              ? 'open_next_lesson'
                              : 'take_new_test')
                          : 'try_agayn',
                      function: () {
                        if (data.isLesson) {
                          context.read<HomeBloc>().add(NextLessonEvent());
                          context.read<TradeBloc>().add(BonusLessonPointsEvent(
                              bonus: (data.bonus ?? 6) * 100));
                          MyNavigatorManager.instance.lessonNextPush();
                        } else {
                          if (data.isW) {
                            context.read<TradeBloc>().add(
                                BonusLessonPointsEvent(
                                    bonus: (data.bonus ?? 6) * 100));
                            context.read<HomeBloc>().add(TestAgainEvent());
                            MyNavigatorManager.instance.termsRessetPush();
                          } else {
                            context.read<HomeBloc>().add(StartTestEvent());
                            MyNavigatorManager.instance.termsRessetPush();
                          }
                        }
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class FinishData {
  final bool isW;
  final int? number;
  final int? bonus;
  final bool isLesson;
  FinishData({
    required this.isW,
    this.number,
    this.bonus,
    required this.isLesson,
  });
}
