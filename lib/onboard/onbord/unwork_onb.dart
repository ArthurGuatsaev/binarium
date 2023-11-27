import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/onboard/onbord/widgets/base_onb.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

class VUnWorkOnb extends StatefulWidget {
  static const String routeName = '/work';

  static Route route() {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const VUnWorkOnb();
        });
  }

  const VUnWorkOnb({super.key});

  @override
  State<VUnWorkOnb> createState() => _VUnWorkOnbState();
}

class _VUnWorkOnbState extends State<VUnWorkOnb> {
  get finArt => null;

  final InAppReview inAppReview = InAppReview.instance;

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.onboardIndex != current.onboardIndex,
      listener: (context, state) {
        if (state.onboardIndex == 0) {
          controller.animateToPage(0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 1) {
          controller.animateToPage(1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 2) {
          MyNavigatorManager.instance.simulatorPop();
        }
      },
      child: PageView(
        padEnds: false,
        pageSnapping: false,
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          VBaseBoard(
            boardParam: VBoardParam(
              image: 'assets/images/unwork_2.png',
              title: 'Calculator',
              body: 'We will help you quickly calculate what you need',
              buttonText: 'Continue',
              function: () => context.read<HomeBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 1),
                  ),
            ),
          ),
          VBaseBoard(
            boardParam: VBoardParam(
              image: 'assets/images/unwork_1.png',
              title: 'Study the market',
              body: 'And share your knowledge in the niche community',
              buttonText: 'Continue',
              function: () => context.read<HomeBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 2),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
