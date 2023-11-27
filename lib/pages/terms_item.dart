import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/models/term.dart';
import 'package:binarium/pages/lesson_finish.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/widgets/timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsItemPage extends StatelessWidget {
  static const String routeName = '/test';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const TermsItemPage());
  }

  const TermsItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.testStatus != current.testStatus,
      listener: (context, state) {
        if (state.testStatus == MyTestStatus.win) {
          final data = FinishData(isW: true, isLesson: false);
          MyNavigatorManager.instance.lessonFinishPush(data);
        }
        if (state.testStatus == MyTestStatus.lose) {
          final data = FinishData(isW: false, isLesson: false);
          MyNavigatorManager.instance.lessonFinishPush(data);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.termsItemIndex != current.termsItemIndex,
                  builder: (context, state) {
                    return Row(
                      children: [
                        for (var i = 0; i <= 5; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: SizedBox(
                                height: 8,
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: state.termsItemIndex == i
                                            ? gradient
                                            : gradientD)),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                BlocBuilder<TradeBloc, TradeState>(
                  buildWhen: (previous, current) =>
                      previous.user.points != current.user.points,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${state.user.points} \$',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        VTimer(duration: 60, date: DateTime.now())
                      ],
                    );
                  },
                ),
                const SizedBox(height: 35),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.testList != current.testList,
                  builder: (context, state) {
                    return SizedBox(
                        height: 400,
                        child: MyTermsItemPageView(testList: state.testList));
                  },
                ),
                const SizedBox(height: 35),
                const Spacer(),
                const SizedBox(height: 15),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.termsItemIndex != current.termsItemIndex,
                  builder: (context, state) {
                    return SizedBox(
                      height: 48,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              state.termsItemIndex != 0
                                  ? Row(
                                      children: [
                                        PageViewControllerLeft(state: state),
                                        const SizedBox(width: 10),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              const SizedBox(width: 10),
                              PageViewControllerButtonRight(state: state)
                            ],
                          ),
                          SizedBox(
                            height: 47,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<HomeBloc, HomeState>(
                                  buildWhen: (previous, current) =>
                                      previous.termsItemIndex !=
                                      current.termsItemIndex,
                                  builder: (context, state) {
                                    final i = state.termsItemIndex + 1;
                                    return Text(
                                      '$i ',
                                      style: const TextStyle(
                                          color: gradColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    );
                                  },
                                ),
                                const Text('term',
                                        style: TextStyle(
                                            color: gradColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700))
                                    .tr(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageViewControllerLeft extends StatelessWidget {
  final HomeState state;
  const PageViewControllerLeft({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context
            .read<HomeBloc>()
            .add(const ChangeTermsTestIndex(next: false)),
        child: SizedBox(
          width: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: gradColor)),
            child: const Center(
                child: Icon(
              Icons.arrow_back,
              color: gradColor,
            )),
          ),
        ),
      ),
    );
  }
}

class PageViewControllerButtonRight extends StatelessWidget {
  final HomeState state;
  const PageViewControllerButtonRight({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (state.termsItemIndex == 5) {
            // MyNavigatorManager.instance
            //     .lessonFinishPush();
          }

          context.read<HomeBloc>().add(const ChangeTermsTestIndex(next: true));
        },
        child: SizedBox(
          width: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: gradColor)),
            child: const Center(
                child: Icon(
              Icons.arrow_forward,
              color: gradColor,
            )),
          ),
        ),
      ),
    );
  }
}

class MyTermsItemPageView extends StatefulWidget {
  final List<Terms> testList;
  const MyTermsItemPageView({
    super.key,
    required this.testList,
  });

  @override
  State<MyTermsItemPageView> createState() => _MyTermsItemPageViewState();
}

class _MyTermsItemPageViewState extends State<MyTermsItemPageView> {
  late final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.termsItemIndex != current.termsItemIndex,
      listener: (context, state) {
        controller.animateToPage(state.termsItemIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.terms != current.terms,
        builder: (context, state) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              for (var i = 0; i < 6; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.testList[i].name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ).tr(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: calculItemColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 15,
                            ),
                            Text(
                              state.test[i] == 0
                                  ? widget.testList[i].rightDescription
                                  : widget.testList[i].wrongDescription,
                              textAlign: TextAlign.start,
                              // maxLines: ,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 48,
                              child: Row(
                                children: [
                                  for (var j = 0; j < 2; j++)
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: InkWell(
                                          onTap: () {
                                            context.read<HomeBloc>().add(
                                                ActiveTestResultEvent(
                                                    index: i, result: j == 0));
                                            context.read<HomeBloc>().add(
                                                const ChangeTermsTestIndex(
                                                    next: true));
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: SizedBox(
                                              height: 48,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: j == 0
                                                        ? Colors.green
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    j == 0 ? 'True' : 'False',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
