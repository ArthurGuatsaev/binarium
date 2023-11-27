import 'package:binarium/auth/domain/bloc/auth/auth_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/const/strings.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/pop_up/pop_up_change_profile.dart';
import 'package:binarium/widgets/pop_up/pop_up_ios_delete.dart';
import 'package:binarium/widgets/pop_up/pop_up_win_trade.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserEvent());
    super.initState();
  }

  final InAppReview inAppReview = InAppReview.instance;
  late final TextEditingController controllerName = TextEditingController();
  late final TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<TradeBloc, TradeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == MyStatus.win || state.status == MyStatus.lose) {
          showWinPop(context, state.history.last);
        }
      },
      child: Stack(
        fit: StackFit.loose,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.53,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (previous, current) =>
                            previous.user != current.user,
                        builder: (context, state) {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: state.user.image,
                                backgroundColor:
                                    state.user.image == null ? gradColor : null,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.user.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(10),
                                color: gradOpasColor,
                                child: InkWell(
                                  onTap: () {
                                    showMyChangeProfileFormPop(
                                        context: context,
                                        controllerName: controllerName,
                                        controllerPassword: controllerPassword);
                                  },
                                  child: SizedBox(
                                    height: 45,
                                    width: 116,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/edit.png'),
                                          const Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: gradColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<TradeBloc, TradeState>(
                        buildWhen: (previous, current) =>
                            previous.user.points != current.user.points,
                        builder: (context, state) {
                          return Text(
                            'Your balance: ${state.user.points}\$',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w200),
                          );
                        },
                      ),
                      const Spacer(),
                      ShareButton(
                        funk: () => shareApp(context: context, text: 'dfdfdf'),
                        text: 'Share App',
                        image: 'assets/images/turn_color.png',
                      ),
                      const SizedBox(height: 7),
                      ShareButton(
                        funk: () => inAppReview.requestReview(),
                        text: 'Rate App',
                        image: 'assets/images/heart.png',
                      ),
                      const SizedBox(height: 7),
                      ShareButton(
                        funk: () => launchPolicy(),
                        text: 'Policy Usage',
                        image: 'assets/images/policy.png',
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                          text: 'Reset all data',
                          color: resetAllDataColor,
                          gradic: gradReset,
                          function: () => showMyIosResetDataPop(context),
                        ),
                      )
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

class ShareButton extends StatelessWidget {
  final String image;
  final String text;
  final Function()? funk;
  const ShareButton({
    super.key,
    required this.image,
    required this.text,
    required this.funk,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: calculItemColor,
      child: InkWell(
        onTap: funk,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(children: [
              Image.asset(image),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )),
              const Icon(
                Icons.navigate_next,
                size: 30,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

void shareApp({required BuildContext context, required String text}) async {
  final box = context.findRenderObject() as RenderBox;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo info = await deviceInfo.iosInfo;
  if (info.model.toLowerCase().contains("ipad")) {
    Share.share(text,
        subject: appName,
        sharePositionOrigin:
            box.localToGlobal(const Offset(0, 0)) & const Size(100, 200));
  } else {
    Share.share(text, subject: appName);
  }
}

void launchPolicy() async {
  final uri = Uri.parse(
      'https://docs.google.com/document/d/1AXCiKvug-eodIY1Z1NWgdE_gzIpjoi5ICTx1eASE7t4/edit');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
