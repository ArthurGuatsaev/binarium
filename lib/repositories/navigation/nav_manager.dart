import 'package:binarium/auth/ui/sign_in.dart';
import 'package:binarium/auth/ui/sign_up.dart';
import 'package:binarium/onboard/onbord/widgets/base_onb.dart';
import 'package:binarium/onboard/onbord/widgets/teleg_board.dart';
import 'package:binarium/pages/error.dart';
import 'package:binarium/pages/finic.dart';
import 'package:binarium/pages/home.dart';
import 'package:binarium/pages/lesson_finish.dart';
import 'package:binarium/pages/lesson_item.dart';
import 'package:binarium/onboard/onbord/unwork_onb.dart';
import 'package:binarium/onboard/onbord/work_onb.dart';
import 'package:binarium/pages/simulator.dart';
import 'package:binarium/pages/splash.dart';
import 'package:binarium/pages/terms_item.dart';
import 'package:binarium/widgets/pop_up/pop_up_ios_delete.dart';
import 'package:flutter/cupertino.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final key = GlobalKey<NavigatorState>();
  late NavigatorState postState;
  NavigatorState? get nav => key.currentState;

  Future<void> postPushNotes() async {
    postState.pushNamed('/notes');
  }

  void navigatorInit(NavigatorState state) {
    postState = state;
  }

  Future<void> postPop() async {
    postState.pop();
  }

  Future<void> simulatorPop() async {
    nav!.pop();
  }

  Future<void> errorPop(String message) async {
    showErrorPop(nav!.context, message);
  }

  Future<void> simulatorPush() async {
    nav!.pushNamed('/simulator');
  }

  Future<void> lessonFinishPush(FinishData data) async {
    nav!.pushReplacementNamed('/lf', arguments: data);
  }

  Future<void> lessonPush() async {
    nav!.pushNamed('/less');
  }

  Future<void> lessonNextPush() async {
    nav!.pushReplacementNamed('/less');
  }

  Future<void> signInPush() async {
    nav!.pushReplacementNamed('/sign_in');
  }

  Future<void> signUpPush() async {
    nav!.pushReplacementNamed('/sign_up');
  }

  Future<void> termsPush() async {
    nav!.pushNamed('/test');
  }

  Future<void> homePush() async {
    nav!.pushReplacementNamed('/home');
  }

  Future<void> finPush(String url) async {
    nav!.pushReplacementNamed('/fin', arguments: url);
  }

  Future<void> unworkBPush() async {
    nav!.pushNamed('/unwork');
  }

  Future<void> workBPush(String tg) async {
    nav!.pushNamed('/work', arguments: tg);
  }

  Future<void> telegaPush(VBoardParam param) async {
    nav!.pushNamed('/tg', arguments: param);
  }

  Future<void> termsRessetPush() async {
    nav!.pushReplacementNamed('/test');
  }

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashPage.route();
      case '/unwork':
        return VUnWorkOnb.route();
      case '/work':
        final tg = settings.arguments as String;
        return VWorkOnb.route(tg);
      case '/tg':
        final tg = settings.arguments as VBoardParam;
        return VBoardTelega.route(tg);
      case '/fin':
        final url = settings.arguments as String;
        return FinicPage.route(url);
      case '/home':
        return HomePage.route();
      case '/lf':
        final data = settings.arguments as FinishData;
        return LessonFinish.route(data);
      case '/test':
        return TermsItemPage.route();
      case '/less':
        return LessonItem.route();
      case '/sign_in':
        return SignInPage.route();
      case '/sign_up':
        return SignUpPage.route();
      case '/simulator':
        return SimulatorPage.route();
      default:
        return ErrorPage.route();
    }
  }
}
