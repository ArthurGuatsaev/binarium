import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/pages/calculate.dart';
import 'package:binarium/pages/lesson.dart';
import 'package:binarium/pages/profile.dart';
import 'package:binarium/pages/terms.dart';
import 'package:binarium/posts/view/ui/posts.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/widgets/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<TradeBloc>()
        .add(GetTradeUserEvent(user: context.read<UserRepo>().myUser!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return IndexedStack(index: state.homeIndex, children: const [
            CalculatePage(),
            LessonPage(),
            TermsPage(),
            VNavi(),
            ProfilePage()
          ]);
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
