import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:binarium/const/colors.dart';
import 'package:binarium/posts/view/bloc/post_bloc.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/pop_up/pop_up_ios_delete.dart';
import 'package:binarium/widgets/pop_up/pop_up_note.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatefulWidget {
  static const String routeName = '/notes';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const NotesPage());
  }

  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'post',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300),
          ).tr(),
          toolbarHeight: 100),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints.loose(Size(
                                    MediaQuery.of(context).size.width, 80)),
                                child: Text(
                                  state.currentPost.title,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                )),
                            const SizedBox(height: 10),
                            ConstrainedBox(
                                constraints: BoxConstraints.loose(Size(
                                    MediaQuery.of(context).size.width, 2000)),
                                child: Text(state.currentPost.body)),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 179,
                              width: MediaQuery.of(context).size.width,
                              child: state.currentPost.image == null
                                  ? const SizedBox.shrink()
                                  : Image(
                                      image: state.currentPost.image!.image,
                                      fit: BoxFit.fitWidth),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  state.currentPost.uiDateFormat,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(width: 10),
                                const CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(state.currentPost.postTime,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                                const Spacer(),
                                Image.asset('assets/images/turn.png'),
                              ],
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              'notes',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                          ]),
                    ),
                    SliverList.builder(
                        itemCount:
                            state.currentNotes[state.currentPost.id]?.length ??
                                0, //
                        itemBuilder: (context, index) {
                          final note =
                              state.currentNotes[state.currentPost.id]![index];
                          final user =
                              context.read<UserRepo>().myUser ?? MyUser();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: gradColor,
                                        radius: 26,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              note.uiDate,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () =>
                                              showMyIosPop(context, note),
                                          child: Image.asset(
                                              'assets/images/trash.png'))
                                    ]),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 26,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.body ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CalcButton(
                  function: () => showMyNoteFormPop(
                      context: context, controller: controller),
                  text: 'leave_new_note',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
