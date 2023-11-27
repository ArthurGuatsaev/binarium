import 'package:binarium/auth/domain/bloc/auth/auth_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showMyChangeProfileFormPop(
    {required BuildContext context,
    required TextEditingController controllerName,
    required TextEditingController controllerPassword}) {
  return showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child);
    },
    pageBuilder: (context, _, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 25, top: 10),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => previous.user != current.user,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  state.user.image == null ? gradColor : null,
                              backgroundImage: state.user.image,
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(ChangeUserImageEvent());
                                },
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child:
                                        Image.asset('assets/images/pick.png')),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controllerName.clear();
                              controllerPassword.clear();
                              MyNavigatorManager.instance.simulatorPop();
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ).tr(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: VTextField(
                          controller: controllerName,
                          hint: state.user.name,
                          inputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ).tr(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: VTextField(
                          controller: controllerPassword,
                          maxLines: 10,
                          hint: state.user.password,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                          text: 'Apply',
                          function: () {
                            context.read<AuthBloc>().add(
                                  ChangeUserDataEvent(
                                    user: state.user.copyWith(
                                        name: controllerName.text.isEmpty
                                            ? state.user.name
                                            : controllerName.text,
                                        password:
                                            controllerPassword.text.length < 6
                                                ? state.user.password
                                                : controllerPassword.text),
                                  ),
                                );
                            controllerName.clear();
                            controllerPassword.clear();
                            MyNavigatorManager.instance.simulatorPop();
                          },
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: 'Sign Out',
                            function: () =>
                                context.read<AuthBloc>().add(LogOutEvent()),
                            color: resetAllDataColor,
                            gradic: gradReset),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: 'Delete Account',
                            function: () => context
                                .read<AuthBloc>()
                                .add(DeleteUserAccountEvent()),
                            color: resetAllDataColor,
                            gradic: gradTrans),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
