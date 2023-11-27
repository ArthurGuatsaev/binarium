import 'dart:async';
import 'dart:math';

import 'package:binarium/const/strings.dart';
import 'package:binarium/lessons/domain/lessons_repo.dart';
import 'package:binarium/lessons/model/lesson.dart';
import 'package:binarium/models/term.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LessonsRepo lessonRepo;
  Timer? timer;
  HomeBloc({required this.lessonRepo}) : super(const HomeState()) {
    on<ChangeHomeIndexEvent>(onChangeHomeIndex);
    on<ChangeViewAllEvent>(onChangeViewAll);
    on<ChangeLessonsIndex>(onChangeLessonsIndex);
    on<ChangeLessonsItemIndex>(onChangeLessonsItemIndex);
    on<ChangeTermsTestIndex>(onChangeTermsTestIndex);
    on<ChangeTermsIndex>(onChangeTermsIndex);
    on<StartTestEvent>(onStartTest);
    on<ActiveTestResultEvent>(onActiveTestResult);
    on<GetLessonsEvent>(onGetLessons);
    on<GetTermsEvent>(onGetTerms);
    on<StatusWinEvent>(onWinStatus);
    on<TestAgainEvent>(onTestAgain);
    on<RessetTestEvent>(onRessetTest);
    on<NextLessonEvent>(onNextLesson);
    on<MixTermsEvent>(onMixTerms);
    on<ChangeOnbIndicatorEvent>(onChangeOnbIndicatorIndex);
  }

  onChangeHomeIndex(ChangeHomeIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(homeIndex: event.homeIndex));
  }

  onChangeOnbIndicatorIndex(
      ChangeOnbIndicatorEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(onboardIndex: event.index));
  }

  onMixTerms(MixTermsEvent event, Emitter<HomeState> emit) {
    final terms = [...state.terms];
    terms.shuffle();
    emit(state.copyWith(terms: terms, termsIndex: 0));
  }

  onChangeLessonsIndex(ChangeLessonsIndex event, Emitter<HomeState> emit) {
    if (event.next) {
      if (state.lessonsIndex == 2) return;
      emit(state.copyWith(lessonsIndex: state.lessonsIndex + 1));
    } else {
      if (state.lessonsIndex == 0) return;
      emit(state.copyWith(lessonsIndex: state.lessonsIndex - 1));
    }
  }

  onNextLesson(NextLessonEvent event, Emitter<HomeState> emit) {
    final index = state.lessonsIndex;
    if (index == 2) {
      return emit(state.copyWith(lessonsIndex: 0));
    }
    emit(state.copyWith(lessonsIndex: state.lessonsIndex + 1));
  }

  onChangeTermsTestIndex(ChangeTermsTestIndex event, Emitter<HomeState> emit) {
    if (event.next) {
      if (state.termsItemIndex == 5) {
        if (!state.activeTest.every((element) => true)) {
          timer!.cancel();
          add(const StatusWinEvent(status: MyTestStatus.win));
        } else {
          timer!.cancel();
          add(const StatusWinEvent(status: MyTestStatus.lose));
        }
        return emit(state.copyWith(termsItemIndex: 0));
      }
      ;
      emit(state.copyWith(termsItemIndex: state.termsItemIndex + 1));
    } else {
      if (state.termsItemIndex == 0) return;
      emit(state.copyWith(termsItemIndex: state.termsItemIndex - 1));
    }
  }

  onTestAgain(TestAgainEvent event, Emitter<HomeState> emit) {
    timer = Timer(const Duration(seconds: 60), () {
      if (!state.activeTest.every((element) => true)) {
        add(const StatusWinEvent(status: MyTestStatus.win));
      } else {
        add(const StatusWinEvent(status: MyTestStatus.lose));
      }
    });
    emit(state.copyWith(testStatus: MyTestStatus.start));
  }

  onWinStatus(StatusWinEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(testStatus: event.status));
    emit(state.copyWith(testStatus: MyTestStatus.initial, termsItemIndex: 0));
  }

  onStartTest(StartTestEvent event, Emitter<HomeState> emit) {
    List<int> test = List.generate(6, (i) => Random().nextInt(2));
    final testlist = state.terms..shuffle();
    emit(state.copyWith(test: test, testList: testlist));
    timer = Timer(const Duration(seconds: 60), () {
      if (!state.activeTest.every((element) => true)) {
        add(const StatusWinEvent(status: MyTestStatus.win));
      } else {
        add(const StatusWinEvent(status: MyTestStatus.lose));
      }
    });
    emit(state.copyWith(testStatus: MyTestStatus.start));
  }

  onGetLessons(GetLessonsEvent event, Emitter<HomeState> emit) {
    final lessons = lessonRepo.lessons ?? [];
    emit(state.copyWith(lessons: lessons));
  }

  onGetTerms(GetTermsEvent event, Emitter<HomeState> emit) async {
    final terms = termsListInitial;
    emit(state.copyWith(terms: terms));
  }

  onActiveTestResult(ActiveTestResultEvent event, Emitter<HomeState> emit) {
    final right = (event.result == true && state.test[event.index] == 0) ||
        (event.result == false && state.test[event.index] == 1);
    if (event.index < state.activeTest.length) {
      final newResult = [...state.activeTest];
      newResult.removeAt(event.index);
      newResult.insert(event.index, right);
      return emit(state.copyWith(activeTest: newResult));
    }
    final newResult = [...state.activeTest];
    newResult.add(right);
    emit(state.copyWith(activeTest: newResult));
  }

  onRessetTest(RessetTestEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(testList: [], test: []));
  }

  onChangeTermsIndex(ChangeTermsIndex event, Emitter<HomeState> emit) {
    if (event.next) {
      if (state.termsIndex == state.terms.length - 1) {
        return emit(state.copyWith(termsIndex: 0));
      }
      ;
      emit(state.copyWith(termsIndex: state.termsIndex + 1));
    } else {
      if (state.termsIndex == 0) return;
      emit(state.copyWith(termsIndex: state.termsIndex - 1));
    }
  }

  onChangeLessonsItemIndex(
      ChangeLessonsItemIndex event, Emitter<HomeState> emit) {
    if (event.next) {
      if (state.lessonsItemIndex ==
          state.lessons[state.lessonsIndex].abc.length - 1) {
        return emit(state.copyWith(lessonsItemIndex: 0));
      }
      emit(state.copyWith(lessonsItemIndex: state.lessonsItemIndex + 1));
    } else {
      if (state.lessonsItemIndex == 0) return;
      emit(state.copyWith(lessonsItemIndex: state.lessonsItemIndex - 1));
    }
  }

  onChangeViewAll(ChangeViewAllEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(viewAll: !state.viewAll));
  }
}
