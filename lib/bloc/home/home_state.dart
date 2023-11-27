// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {
  final bool isWorker;
  final int homeIndex;
  final int lessonsIndex;
  final int lessonsItemIndex;
  final int termsIndex;
  final int onboardIndex;
  final int termsItemIndex;
  final MyTestStatus testStatus;
  final List<int> test;
  final List<Terms> testList;

  final List<bool> activeTest;
  final List<Terms> terms;
  final List<Lesson> lessons;
  final bool isAHistory;
  final bool viewAll;
  final OrderData orderData;
  const HomeState({
    this.isWorker = true,
    this.onboardIndex = 0,
    this.termsIndex = 0,
    this.termsItemIndex = 0,
    this.testList = const [],
    this.test = const [],
    this.lessonsIndex = 0,
    this.lessons = const [],
    this.activeTest = const [],
    this.testStatus = MyTestStatus.initial,
    this.terms = const [],
    this.lessonsItemIndex = 0,
    this.viewAll = false,
    this.homeIndex = 0,
    this.orderData = const OrderData(),
    this.isAHistory = true,
  });

  HomeState copyWith(
      {bool? isWorker,
      bool? viewAll,
      int? termsItemIndex,
      int? termsIndex,
      List<int>? test,
      int? onboardIndex,
      List<Lesson>? lessons,
      List<Terms>? terms,
      List<Terms>? testList,
      int? lessonsIndex,
      List<bool>? activeTest,
      OrderData? orderData,
      MyTestStatus? testStatus,
      int? lessonsItemIndex,
      bool? isAHistory,
      int? homeIndex}) {
    return HomeState(
        termsIndex: termsIndex ?? this.termsIndex,
        isWorker: isWorker ?? this.isWorker,
        activeTest: activeTest ?? this.activeTest,
        testList: testList ?? this.testList,
        onboardIndex: onboardIndex ?? this.onboardIndex,
        viewAll: viewAll ?? this.viewAll,
        test: test ?? this.test,
        lessons: lessons ?? this.lessons,
        testStatus: testStatus ?? this.testStatus,
        termsItemIndex: termsItemIndex ?? this.termsItemIndex,
        lessonsItemIndex: lessonsItemIndex ?? this.lessonsItemIndex,
        lessonsIndex: lessonsIndex ?? this.lessonsIndex,
        terms: terms ?? this.terms,
        orderData: orderData ?? this.orderData,
        isAHistory: isAHistory ?? this.isAHistory,
        homeIndex: homeIndex ?? this.homeIndex);
  }
}

class OrderData {
  final List<MyOrder> history;
  final Map<String, MyOrder> activeOrders;
  const OrderData({
    this.history = const [],
    this.activeOrders = const {},
  });

  OrderData copyWith({
    List<MyOrder>? history,
    Map<String, MyOrder>? activeOrders,
  }) {
    return OrderData(
      history: history ?? this.history,
      activeOrders: activeOrders ?? this.activeOrders,
    );
  }
}

enum MyTestStatus { initial, start, win, lose }
