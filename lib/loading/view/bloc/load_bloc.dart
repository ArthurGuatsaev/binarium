import 'dart:async';
import 'package:binarium/const/strings.dart';
import 'package:binarium/lessons/domain/lessons_repo.dart';
import 'package:binarium/loading/domain/model/failed_model.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:binarium/loading/domain/repositories/check_repo.dart';
import 'package:binarium/loading/domain/repositories/loading_repo.dart';
import 'package:binarium/loading/domain/repositories/remote_confige.dart';
import 'package:binarium/loading/domain/repositories/services_repo.dart';
import 'package:binarium/posts/repository/post_repo.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:bloc/bloc.dart';

part 'load_event.dart';
part 'load_state.dart';

class LoadBloc extends Bloc<LoadEvent, LoadState> {
  final StreamController<VLoading> controller = StreamController();
  LoadingRepo? loadingRepo;
  FirebaseRemote? firebaseRemote;
  MyCheckRepo? checkRepo;
  UserRepo? userRepo;
  VPostRepo? postRepo;
  LessonsRepo? lessonRepo;
  VServices? servicesRepo;
  LoadBloc({
    this.loadingRepo,
    this.firebaseRemote,
    this.checkRepo,
    this.servicesRepo,
    this.lessonRepo,
    this.postRepo,
    this.userRepo,
  }) : super(LoadState()) {
    controller.stream.listen(
      (event) {
        print(event);
        add(LoadingProgressEvent(event: event));
      },
    );

    on<OnBoardCheckEvent>(onOnboardInit);
    on<FirebaseRemoteInitEvent>(onFirebaseRemoteInit);
    on<CheckRepoInitEvent>(onCheckRepoInit);
    on<UserRepoInitEvent>(onUserRepoInit);
    on<LessonsRepoInitEvent>(onLessonsRepoInit);
    on<LoadingProgressEvent>(onLoadingProgressEvent);
    on<PostRepoInitEvent>(onPostRepoInit);
  }
  onLoadingProgressEvent(
      LoadingProgressEvent event, Emitter<LoadState> emit) async {
    final loadList = [...state.loadingList];
    loadList.add(event.event);
    emit(state.copyWith(loadingList: loadList));
    if (loadList.length == VLoading.values.length - 3) {
      final url = firebaseRemote?.url ?? 'https://youtube.com/';
      final tg = firebaseRemote?.tg ?? 'https://telegram.com/';
      if (userRepo!.myUser != null) {
        if (state.loadingList.contains(VLoading.finanseModeTrue)) {
          if (state.loadingList.contains(VLoading.firstShowTrue)) {
            MyNavigatorManager.instance.finPush(url);
            MyNavigatorManager.instance.workBPush(tg);
          } else {
            MyNavigatorManager.instance.finPush(url);
            if (state.loadingList.contains(VLoading.tgTrue)) {
              MyNavigatorManager.instance.telegaPush(telegaParam(tg));
            }
          }
        } else {
          if (state.loadingList.contains(VLoading.firstShowTrue)) {
            MyNavigatorManager.instance.homePush();
            MyNavigatorManager.instance.unworkBPush();
          } else {
            MyNavigatorManager.instance.homePush();
          }
        }
      } else {
        if (state.loadingList.contains(VLoading.finanseModeTrue)) {
          if (state.loadingList.contains(VLoading.firstShowTrue)) {
            MyNavigatorManager.instance.finPush(url);
            MyNavigatorManager.instance.workBPush(tg);
          } else {
            MyNavigatorManager.instance.finPush(url);
            if (state.loadingList.contains(VLoading.tgTrue)) {
              MyNavigatorManager.instance.telegaPush(telegaParam(tg));
            }
          }
        } else {
          if (state.loadingList.contains(VLoading.firstShowTrue)) {
            MyNavigatorManager.instance.signInPush();
            MyNavigatorManager.instance.unworkBPush();
          } else {
            MyNavigatorManager.instance.signInPush();
            MyNavigatorManager.instance.unworkBPush();
          }
        }
      }
    }
  }

  onOnboardInit(OnBoardCheckEvent event, Emitter<LoadState> emit) async {
    if (loadingRepo == null) return;
    try {
      await loadingRepo!.getIsFirstShow(controller: controller);
      await loadingRepo!.isFinanseMode(
          isDead: event.isDead,
          controller: controller,
          isChargh: event.isChargh,
          isVpn: event.isVpn,
          procentChargh: event.procentChargh,
          udid: event.udid);
    } catch (e) {
      emit(state.copyWith(
          status: StatusLoadState.failed,
          failed: const VFailed(message: 'No internet connection')));
    }
  }

  onFirebaseRemoteInit(
      FirebaseRemoteInitEvent event, Emitter<LoadState> emit) async {
    try {
      if (firebaseRemote == null) return;
      await servicesRepo!.initApphud(controller: controller);
      await servicesRepo!.initAmplitude(controller: controller);
      await firebaseRemote!.initialize(
          streamController: controller, userId: servicesRepo!.userId);
      add(CheckRepoInitEvent(
        isDead: firebaseRemote!.isDead,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: StatusLoadState.failed,
          failed: const VFailed(message: 'No internet connection')));
    }
  }

  onCheckRepoInit(CheckRepoInitEvent event, Emitter<LoadState> emit) async {
    if (checkRepo == null) return;
    try {
      await checkRepo!.checkBattery(streamController: controller);
      await checkRepo!.checkVpn(streamController: controller);
      await checkRepo!.checkDeviceInfo(streamController: controller);
      add(OnBoardCheckEvent(
          isDead: event.isDead,
          isChargh: checkRepo!.isChargh ?? false,
          isVpn: checkRepo!.isVpn!,
          procentChargh: checkRepo!.procentChargh ?? 70,
          udid: checkRepo!.udid!));
    } catch (e) {
      print('check error');
    }
  }

  onLessonsRepoInit(LessonsRepoInitEvent event, Emitter<LoadState> emit) async {
    if (lessonRepo == null) return;
    try {
      await lessonRepo!.getLessons(controller: controller);
    } catch (e) {
      print('lessons load error');
    }
  }

  onUserRepoInit(UserRepoInitEvent event, Emitter<LoadState> emit) async {
    if (userRepo == null) return;
    try {
      if (await userRepo!.isAuth()) {
        await userRepo!.getUser(controller: controller);
      } else {
        controller.add(VLoading.getUser);
      }
    } catch (e) {
      print('user auth load error');
    }
  }

  onPostRepoInit(PostRepoInitEvent event, Emitter<LoadState> emit) async {
    if (postRepo == null) return;
    await postRepo!.getNote(controller);
  }
}
