import 'dart:async';

import 'package:binarium/auth/domain/bloc/auth/auth_bloc.dart';
import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/error/domain/bloc/error_bloc.dart';
import 'package:binarium/firebase_options.dart';
import 'package:binarium/lessons/domain/lessons_repo.dart';
import 'package:binarium/loading/domain/repositories/check_repo.dart';
import 'package:binarium/loading/domain/repositories/loading_repo.dart';
import 'package:binarium/loading/domain/repositories/remote_confige.dart';
import 'package:binarium/loading/domain/repositories/services_repo.dart';
import 'package:binarium/loading/view/bloc/load_bloc.dart';
import 'package:binarium/pages/splash.dart';
import 'package:binarium/posts/model/note_model.dart';
import 'package:binarium/posts/repository/post_repo.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/trade/domain/repo/trade_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([IsarOrderSchema, VNotesIssarSchema],
      directory: appDir.path);
  final StreamController<String> errorController = StreamController();
  final error = ErrorBloc(errorController: errorController);
  final VPostRepo postRepo =
      VPostRepo(errorController: errorController, isar: isar);
  final TradeRepo tradeRepo =
      TradeRepo(errorController: errorController, isar: isar);
  final UserRepo userRepo = UserRepo(errorController: errorController);
  final VServices services = VServices();
  final MyCheckRepo checkRepo = MyCheckRepo(errorController: errorController);
  final LoadingRepo onbordRepo = LoadingRepo(errorController: errorController);
  final FirebaseRemote firebaseRemote =
      FirebaseRemote(errorController: errorController);
  final LessonsRepo lessonRepo = LessonsRepo(errorController: errorController);
  final navi = MyNavigatorManager.instance;
  final load = LoadBloc(
      servicesRepo: services,
      postRepo: postRepo,
      loadingRepo: onbordRepo,
      lessonRepo: lessonRepo,
      checkRepo: checkRepo,
      firebaseRemote: firebaseRemote,
      userRepo: userRepo)
    ..add(FirebaseRemoteInitEvent())
    ..add(UserRepoInitEvent())
    ..add(LessonsRepoInitEvent())
    ..add(PostRepoInitEvent());
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(
        navi: navi,
        load: load,
        postRepo: postRepo,
        checkRepo: checkRepo,
        tradeRepo: tradeRepo,
        firebaseRemote: firebaseRemote,
        lessonRepo: lessonRepo,
        onbordRepo: onbordRepo,
        error: error,
        userRepo: userRepo,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo;
  final MyCheckRepo checkRepo;
  final LoadingRepo onbordRepo;
  final FirebaseRemote firebaseRemote;
  final LessonsRepo lessonRepo;
  final MyNavigatorManager navi;
  final VPostRepo postRepo;
  final TradeRepo tradeRepo;
  final LoadBloc load;
  final ErrorBloc error;
  const MyApp(
      {super.key,
      required this.postRepo,
      required this.tradeRepo,
      required this.navi,
      required this.load,
      required this.error,
      required this.userRepo,
      required this.checkRepo,
      required this.onbordRepo,
      required this.firebaseRemote,
      required this.lessonRepo});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => userRepo,
        ),
        RepositoryProvider(
          create: (context) => postRepo,
        ),
        RepositoryProvider(
          create: (context) => checkRepo,
        ),
        RepositoryProvider(
          create: (context) => onbordRepo,
        ),
        RepositoryProvider(
          create: (context) => firebaseRemote,
        ),
        RepositoryProvider(
          create: (context) => lessonRepo,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoadBloc>(
            create: (context) => load,
          ),
          BlocProvider<ErrorBloc>(
            create: (context) => error,
          ),
          BlocProvider<TradeBloc>(
            lazy: false,
            create: (context) =>
                TradeBloc(repo: tradeRepo)..add(GetValuteList()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) =>
                HomeBloc(lessonRepo: context.read<LessonsRepo>())
                  ..add(GetTermsEvent()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                controller: StreamController<MyUser>(),
                authRepo: context.read<UserRepo>()),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          navigatorKey: navi.key,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodySmall: TextStyle(fontSize: 10),
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              labelSmall: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              displaySmall: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          onGenerateRoute: navi.onGenerateRoute,
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
