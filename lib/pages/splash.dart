import 'package:binarium/const/colors.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:binarium/loading/view/bloc/load_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SplashPage());
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadProgress = 0;
  late final double width;
  late double pading;
  @override
  void didChangeDependencies() {
    pading = MediaQuery.of(context).size.width / 3.5;
    width = MediaQuery.of(context).size.width - pading * 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/chart.png',
                  fit: BoxFit.cover,
                  height: 461,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 215),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  height: 180,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.45),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pading),
                child: SizedBox(
                  height: 8,
                  width: width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<LoadBloc, LoadState>(
                        buildWhen: (previous, current) =>
                            previous.loadingList != current.loadingList,
                        builder: (context, state) {
                          loadProgress =
                              (width / (VLoading.values.length - 3)) *
                                  (state.loadingList.length + 0.8);
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: loadProgress,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: splashLoadingColor),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
