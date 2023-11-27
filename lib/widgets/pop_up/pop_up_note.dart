import 'package:binarium/posts/model/note_model.dart';
import 'package:binarium/posts/view/bloc/post_bloc.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

Future<dynamic> showMyNoteFormPop(
    {required BuildContext context,
    required TextEditingController controller}) {
  return showGeneralDialog(
    context: context,
    useRootNavigator: false,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child);
    },
    pageBuilder: (context, _, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
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
                            child: const Text('create_new_note',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300))
                                .tr()),
                        GestureDetector(
                          onTap: () {
                            controller.clear();

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
                    'note_text',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ).tr(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      child: VTextField(
                        controller: controller,
                        maxLines: 30,
                        hint: 'Enter text',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: 48,
                      child: BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          return CalcButton(
                            text: 'publish',
                            function: () {
                              context.read<PostBloc>().add(SaveNoteEvent(
                                  note: VNotesIssar()
                                    ..title = ''
                                    ..iD = state.currentPost.id
                                    ..body = controller.text
                                    ..date = DateTime.now()
                                    ..id = Isar.autoIncrement));
                              controller.clear();
                              MyNavigatorManager.instance.postPop();
                            },
                          );
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
