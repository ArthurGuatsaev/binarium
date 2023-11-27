import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/pages/lesson_finish.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonItem extends StatelessWidget {
  static const String routeName = '/less';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const LessonItem());
  }

  const LessonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.lessonsItemIndex != current.lessonsItemIndex,
                builder: (context, state) {
                  return Row(
                    children: [
                      for (var i = 0;
                          i <= state.lessons[state.lessonsIndex].abc.length - 1;
                          i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SizedBox(
                              height: 8,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: state.lessonsItemIndex == i
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
                  return Text(
                    '${state.user.points} \$',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  );
                },
              ),
              const SizedBox(height: 35),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.lessonsIndex != current.lessonsIndex,
                builder: (context, state) {
                  final lesson = state.lessons[state.lessonsIndex];
                  return Text(
                    lesson.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.lessonsIndex != current.lessonsIndex,
                builder: (context, state) {
                  final lesson = state.lessons[state.lessonsIndex];
                  return MyLessonItemPageView(
                    content: lesson.abc,
                  );
                },
              ),
              Spacer(),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.lessonsItemIndex != current.lessonsItemIndex,
                builder: (context, state) {
                  return SizedBox(
                    height: 48,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            state.lessonsItemIndex != 0
                                ? Row(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => context
                                              .read<HomeBloc>()
                                              .add(const ChangeLessonsItemIndex(
                                                  next: false)),
                                          child: SizedBox(
                                            width: 48,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: gradColor)),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.arrow_back,
                                                color: gradColor,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (state.lessonsItemIndex ==
                                      state.lessons[state.lessonsIndex].abc
                                              .length -
                                          1) {
                                    final x = state
                                        .lessons[state.lessonsIndex].abc.length;
                                    final data = FinishData(
                                        isLesson: true,
                                        isW: true,
                                        number: x - 1,
                                        bonus: x);
                                    MyNavigatorManager.instance
                                        .lessonFinishPush(
                                      data,
                                    );
                                  }
                                  context.read<HomeBloc>().add(
                                      const ChangeLessonsItemIndex(next: true));
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
                            )
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
                                    previous.lessonsItemIndex !=
                                    current.lessonsItemIndex,
                                builder: (context, state) {
                                  final i = state.lessonsItemIndex + 1;
                                  return Text(
                                    '$i ',
                                    style: const TextStyle(
                                        color: gradColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                              ),
                              const Text('card',
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
    );
  }
}

class MyLessonItemPageView extends StatefulWidget {
  final List<String> content;
  const MyLessonItemPageView({super.key, required this.content});

  @override
  State<MyLessonItemPageView> createState() => _MyLessonItemPageViewState();
}

class _MyLessonItemPageViewState extends State<MyLessonItemPageView> {
  late final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.lessonsItemIndex != current.lessonsItemIndex,
      listener: (context, state) {
        controller.animateToPage(state.lessonsItemIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      },
      child: SizedBox(
        height: 312,
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < widget.content.length; i++)
              LessonItemContent(
                text: widget.content[i],
              ),
          ],
        ),
      ),
    );
  }
}

class LessonItemContent extends StatelessWidget {
  final String text;
  const LessonItemContent({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: calculItemColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: const Text(
                'pts_win',
                style: TextStyle(color: gradColor, fontWeight: FontWeight.w300),
              ).tr(),
            )
          ],
        ),
      ),
    );
  }
}
