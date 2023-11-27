import 'package:binarium/auth/domain/bloc/auth/auth_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign_in';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SignInPage());
  }

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final _controllerName = TextEditingController();
  late final _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 50, top: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Center(
                        child: Image.asset(
                      'assets/images/logo.png',
                      height: MediaQuery.of(context).size.height * 0.15,
                    )),
                    SizedBox(height: 70),
                    Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Your name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 48,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: calculItemColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: _controllerName,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: hintColor,
                                      fontWeight: FontWeight.w300),
                                  hintText: 'Enter your name',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Your Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 48,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: calculItemColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: _controllerPassword,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: hintColor,
                                      fontWeight: FontWeight.w300),
                                  hintText: 'Enter your password',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CalcButton(
                      text: 'Sign In',
                      function: () => context.read<AuthBloc>().add(
                            SignInEvent(
                                name: _controllerName.text,
                                password: _controllerPassword.text),
                          ),
                    ),
                    const Spacer(),
                    const Text(
                      'Not registed yet? No problem!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    CalcButton(
                      text: 'Create Account',
                      function: () => MyNavigatorManager.instance.signUpPush(),
                      gradic: gradientD,
                      color: gradColor,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
