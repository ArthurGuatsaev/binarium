import 'package:binarium/const/colors.dart';
import 'package:binarium/posts/view/bloc/post_bloc.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showMyPostFormPop(
    {required BuildContext context,
    required TextEditingController controllerTitle,
    required TextEditingController controllerText}) {
  return showGeneralDialog(
    useRootNavigator: false,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 25, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        Expanded(
                            child: const Text('create_a_post',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300))
                                .tr()),
                        GestureDetector(
                          onTap: () {
                            controllerText.clear();
                            controllerTitle.clear();
                            context.read<PostBloc>().add(InitialPostEvent());
                            MyNavigatorManager.instance.postPop();
                          },
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'post_title',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ).tr(),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 48,
                    child: VTextField(
                      controller: controllerTitle,
                      hint: 'Enter title',
                      inputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'post_text',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ).tr(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      child: VTextField(
                        controller: controllerText,
                        maxLines: 10,
                        hint: 'Enter text',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'add_image',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ).tr(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      context.read<PostBloc>().add(PostImageEvent());
                    },
                    child: BlocBuilder<PostBloc, PostState>(
                      buildWhen: (previous, current) =>
                          previous.postImage != current.postImage,
                      builder: (context, state) {
                        return SizedBox(
                          height: 86,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: calculItemColor),
                            child: state.postImage == null
                                ? Center(
                                    child:
                                        Image.asset('assets/images/camara.png'),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 86,
                                    child: Image.memory(
                                      state.postImage!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: 48,
                      child: CalcButton(
                        text: 'publish',
                        function: () {
                          final user = context.read<UserRepo>().myUser;
                          context.read<PostBloc>().add(AddPostsEvent(
                              text: controllerText.text,
                              userToken: user!.token,
                              user: user,
                              title: controllerTitle.text));
                          controllerText.clear();
                          controllerTitle.clear();
                          MyNavigatorManager.instance.postPop();
                        },
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
