import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/models/term.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  double load = 1 / 14;
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
                    previous.termsIndex != current.termsIndex,
                builder: (context, state) {
                  if (state.termsIndex != 0) {
                    load = (state.termsIndex + 1) / state.terms.length;
                  } else {
                    load = 1 / 14;
                  }
                  return LinearProgressIndicator(
                    value: load,
                    backgroundColor: gradColor.withOpacity(0.2),
                    color: gradColor,
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
              const Text(
                'terms',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ).tr(),
              const SizedBox(height: 35),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.terms != current.terms,
                builder: (context, state) {
                  return MyTermsPageView(content: state.terms);
                },
              ),
              const Spacer(),
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: CalcButton(
                          text: 'mix_terms',
                          function: () {
                            context.read<HomeBloc>().add(MixTermsEvent());
                          },
                          gradic: gradientD,
                          color: gradColor),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          previous.testStatus != current.testStatus ||
                          previous.terms != current.terms,
                      builder: (context, state) {
                        return SizedBox(
                          height: 48,
                          child: CalcButton(
                            text: 'check_your',
                            function: () {
                              context.read<HomeBloc>().add(StartTestEvent());
                              MyNavigatorManager.instance.termsPush();
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.termsIndex != current.termsIndex,
                builder: (context, state) {
                  return SizedBox(
                    height: 48,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            state.termsIndex != 0
                                ? Row(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => context
                                              .read<HomeBloc>()
                                              .add(const ChangeTermsIndex(
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
                            state.termsIndex == state.terms.length - 1
                                ? const SizedBox.shrink()
                                : Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        context.read<HomeBloc>().add(
                                            const ChangeTermsIndex(next: true));
                                      },
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
                        ),
                        SizedBox(
                          height: 47,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<HomeBloc, HomeState>(
                                buildWhen: (previous, current) =>
                                    previous.termsIndex != current.termsIndex,
                                builder: (context, state) {
                                  final i = state.termsIndex + 1;
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
    );
  }
}

class MyTermsPageView extends StatefulWidget {
  final List<Terms> content;
  const MyTermsPageView({super.key, required this.content});

  @override
  State<MyTermsPageView> createState() => _MyTermsPageViewState();
}

class _MyTermsPageViewState extends State<MyTermsPageView> {
  late final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.termsIndex != current.termsIndex,
      listener: (context, state) {
        controller.animateToPage(state.termsIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      },
      child: SizedBox(
        height: 250,
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < widget.content.length; i++)
              TermsContent(
                term: widget.content[i],
              ),
          ],
        ),
      ),
    );
  }
}

class TermsContent extends StatelessWidget {
  final Terms term;
  const TermsContent({
    super.key,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 312,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: calculItemColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  '${term.name} -',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  term.rightDescription,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
