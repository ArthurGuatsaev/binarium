// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/lessons/model/lesson.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetLessonsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const MyPageViewImage(),
          ),
        ),
        const LessonContent()
      ],
    );
  }
}

class MyPageViewImage extends StatefulWidget {
  const MyPageViewImage({
    super.key,
  });

  @override
  State<MyPageViewImage> createState() => _MyPageViewImageState();
}

class _MyPageViewImageState extends State<MyPageViewImage> {
  late final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.lessonsIndex != current.lessonsIndex,
      listener: (context, state) {
        controller.animateToPage(state.lessonsIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      },
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Image.asset(
            'assets/images/lesson.png',
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Image.asset(
            'assets/images/lesson_two.png',
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Container(
            decoration: const BoxDecoration(gradient: gradient),
            child: Image.asset(
              'assets/images/test.png',
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}

class LessonContent extends StatelessWidget {
  const LessonContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.32,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 15, bottom: 20),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: const Text(
                      'lesson',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ).tr()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          buildWhen: (previous, current) =>
                              previous.lessonsIndex != current.lessonsIndex,
                          builder: (context, state) {
                            return Text(
                              '${state.lessonsIndex + 1}',
                              style: const TextStyle(
                                  color: gradColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            );
                          },
                        ),
                        const Text('/3'),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.lessons != current.lessons,
                    builder: (context, state) {
                      return MyPageView(lessons: state.lessons);
                    },
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.lessonsIndex != current.lessonsIndex,
                    builder: (context, state) {
                      return Row(
                        children: [
                          state.lessonsIndex != 0
                              ? Row(
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => context
                                            .read<HomeBloc>()
                                            .add(const ChangeLessonsIndex(
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
                          Expanded(
                            child: CalcButton(
                              text: 'take_lesson',
                              function: () {
                                MyNavigatorManager.instance.lessonPush();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          state.lessonsIndex == 2
                              ? const SizedBox.shrink()
                              : Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => context.read<HomeBloc>().add(
                                        const ChangeLessonsIndex(next: true)),
                                    child: SizedBox(
                                      width: 48,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: gradColor)),
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
                      );
                    },
                  ),
                )
              ]),
            ),
          )),
    );
  }
}

class MyPageView extends StatefulWidget {
  final List<Lesson> lessons;
  const MyPageView({
    super.key,
    required this.lessons,
  });

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.lessonsIndex != current.lessonsIndex,
      listener: (context, state) {
        controller.animateToPage(state.lessonsIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      },
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var i = 0; i < widget.lessons.length; i++)
            LessonData(
              title: widget.lessons[i].title,
              subtitle: widget.lessons[i].description,
            ),
        ],
      ),
    );
  }
}

class LessonData extends StatelessWidget {
  final String title;
  final String subtitle;
  const LessonData({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            )),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
                child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ))
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
