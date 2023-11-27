import 'package:binarium/posts/repository/post_repo.dart';
import 'package:binarium/posts/view/bloc/post_bloc.dart';
import 'package:binarium/posts/view/ui/notes.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/widgets/calc_button.dart';
import 'package:binarium/widgets/pop_up/pop_up_post.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VNavi extends StatelessWidget {
  const VNavi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PostBloc(postRepo: context.read<VPostRepo>())
        ..add(GetPostsEvent())
        ..add(GetNotesEvent()),
      child: Navigator(
        initialRoute: '/posts',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/posts':
              return PostPage.route();
            case 'notes':
              return NotesPage.route();
            default:
              return NotesPage.route();
          }
        },
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  static const String routeName = '/posts';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const PostPage());
  }

  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    MyNavigatorManager.instance
        .navigatorInit(context.findAncestorStateOfType<NavigatorState>()!);
    super.initState();
  }

  late final TextEditingController controllerTitle = TextEditingController();
  late final TextEditingController controllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset(
                    'assets/images/posts.png',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width),
                        Center(
                            child: Text(
                          'community'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ).tr())
                      ]),
                    ),
                  ),
                ),
              ),
              BlocBuilder<PostBloc, PostState>(
                buildWhen: (previous, current) =>
                    previous.posts.length != current.posts.length,
                builder: (context, state) {
                  return SliverList.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<PostBloc>()
                                  .add(FindCurrentPost(index: index));
                              MyNavigatorManager.instance.postPushNotes();
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              post.author.image?.image,
                                          backgroundColor: Colors.grey,
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
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  post.author.name,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  post.uiDate,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 26,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              post.title,
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              post.body,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: post.image != null
                                                ? Image(
                                                    image: post.image!.image)
                                                : const SizedBox.shrink(),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<PostBloc>()
                                                        .add(FindCurrentPost(
                                                            index: index));
                                                    MyNavigatorManager.instance
                                                        .postPushNotes();
                                                  },
                                                  child: Image.asset(
                                                      'assets/images/comment.png')),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: BlocBuilder<PostBloc,
                                                      PostState>(
                                                buildWhen: (previous,
                                                        current) =>
                                                    previous.currentNotes[state
                                                        .posts[index].id] !=
                                                    current.currentNotes[
                                                        state.posts[index].id],
                                                builder: (context, state) {
                                                  final number = state
                                                          .currentNotes[state
                                                              .posts[index].id]
                                                          ?.length ??
                                                      0;
                                                  return Text(
                                                    '$number notes',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  );
                                                },
                                              )),
                                              GestureDetector(
                                                onTap: () {
                                                  context.read<PostBloc>().add(
                                                      DelPostsEvent(
                                                          userToken:
                                                              '${post.author.name}${post.author.name}-123', //My user 1My user 1-123
                                                          id: post.id));
                                                },
                                                child: Image.asset(
                                                    'assets/images/turn.png'),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          )
                                        ],
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 40),
                child: CalcButton(
                  text: 'create_post',
                  function: () => showMyPostFormPop(
                      context: context,
                      controllerTitle: controllerTitle,
                      controllerText: controllerText),
                ),
              ))
        ],
      ),
    );
  }
}
