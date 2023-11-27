// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:binarium/const/strings.dart';
import 'package:binarium/trade/domain/model/calculate_model.dart';
import 'package:binarium/trade/domain/model/price.dart';
import 'package:bloc/bloc.dart';

import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/trade/data/trade_api.dart';
import 'package:binarium/trade/domain/model/charts_model.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:binarium/trade/domain/repo/trade_repo.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeRepo repo;
  TradeBloc({required this.repo})
      : super(TradeState(order: MyOrder.initial(), user: MyUser())) {
    on<GetTimerUpdateChartEvent>(onGetTimer);
    on<GetCurrentChartsEvent>(onGetCharts);
    on<GetHistoryEvent>(onGetHistory);
    on<AddOrderEvent>(onAddOrder);
    on<SetOrderTimeEvent>(onSetTimeOrder);
    on<SetOrderPointEvent>(onSetPointOrder);
    on<StopOrderEvent>(onStopOrder);
    on<ChangeCurrentTime>(onChangeCurrentTime);
    on<ChangeCurrentPrice>(onChangeCurrentPrice);
    on<ChangeCurrentValute>(onChangeCurrentValute);
    on<ChangeIsAHistoryEvent>(onChangeIsAHistory);
    on<CalculateValuteEvent>(onCalculateValute);
    on<GetTradeUserEvent>(onGetUser);
    on<BonusLessonPointsEvent>(onBonusLessonPointsEvent);
    on<ResetAllEvent>(onResetAll);
    on<GetValuteList>(onGetValuteList);
    on<ChangeValuteList>(onChangeValuteList);
  }

  onGetTimer(GetTimerUpdateChartEvent event, Emitter<TradeState> emit) async {
    try {
      Timer.periodic(const Duration(seconds: 30), (timer) async {
        add(GetCurrentChartsEvent());
      });
    } catch (e) {
      emit(state.copyWith(charts: []));
    }
  }

  onGetUser(GetTradeUserEvent event, Emitter<TradeState> emit) {
    emit(state.copyWith(user: event.user));
  }

  onResetAll(ResetAllEvent event, Emitter<TradeState> emit) async {
    await repo.resete();
    emit(state.copyWith(user: state.user.copyWith(points: 5000)));
  }

  onBonusLessonPointsEvent(
      BonusLessonPointsEvent event, Emitter<TradeState> emit) async {
    final points = event.bonus.toInt() + state.user.points;
    await repo.saveUserPoints(login: state.user.login, point: points);
    emit(state.copyWith(user: state.user.copyWith(points: points)));
  }

  onGetCharts(GetCurrentChartsEvent event, Emitter<TradeState> emit) async {
    try {
      final list = await ApiClentTrade.getCourse(
          valute: state.priceModel.currentValute,
          time: DateTime.now().subtract(const Duration(minutes: 30)));

      emit(state.copyWith(
          charts: list,
          calculateData: state.calculateData
              .copyWith(lastCurrentValute: state.priceModel.currentValute)));
      final opens = list.first.open;
      if (!list.any((element) => element.open != opens)) {
        emit(state.copyWith(isWorker: false));
      }
    } catch (e) {
      emit(state.copyWith(charts: []));
    }
  }

  onGetHistory(GetHistoryEvent event, Emitter<TradeState> emit) async {
    final hist = await repo.getHistoryOrder();
    hist.sort((a, b) => b.date.compareTo(a.date));
    emit(state.copyWith(history: hist));
  }

  onGetValuteList(GetValuteList event, Emitter<TradeState> emit) async {
    final valuteList = valute.values.toList();
    emit(state.copyWith(
        calculateData: state.calculateData.copyWith(valuteList: valuteList)));
  }

  onChangeValuteList(ChangeValuteList event, Emitter<TradeState> emit) async {
    final valuteList = [...state.calculateData.valuteList];
    final valute = valuteList.removeAt(event.index);
    valuteList.insert(0, valute);
    emit(state.copyWith(
        calculateData: state.calculateData
            .copyWith(valuteList: valuteList, favoriteValute: valute)));
  }

  onChangeIsAHistory(
      ChangeIsAHistoryEvent event, Emitter<TradeState> emit) async {
    emit(state.copyWith(isActiveH: event.isActiveH));
  }

  onAddOrder(AddOrderEvent event, Emitter<TradeState> emit) async {
    try {
      if (state.user.points < state.order.price ||
          state.priceModel.currentPrice == 0 ||
          state.priceModel.currentTime == 0) {
        return emit(state.copyWith(status: MyStatus.error));
      }
      if (!state.isWorker) return;
      final charts = await ApiClentTrade.getCourse(
          time: DateTime.now().subtract(const Duration(minutes: 30)),
          valute: state.priceModel.currentValute);
      emit(state.copyWith(charts: charts));
      final id = DateTime.now();
      final order = state.order.copyWith(
          cost: state.cost,
          price: state.priceModel.currentPrice,
          valute: state.priceModel.currentValute,
          isActive: true,
          date: id,
          time: state.priceModel.currentTime,
          myId: id.microsecond.toString(),
          promise: event.value);
      final activeOrders = {...state.activeOrders};
      activeOrders[order.myId] = order;
      emit(state.copyWith(
        activeOrders: activeOrders,
        user: state.user.copyWith(points: state.user.points - order.price),
        order: MyOrder.initial(),
      ));
      await repo.saveUserPoints(
          point: state.user.points, login: state.user.login);
      Timer(
        Duration(seconds: order.time),
        () {
          add(StopOrderEvent(id: order.myId));
        },
      );
    } catch (_) {}
  }

  onSetTimeOrder(SetOrderTimeEvent event, Emitter<TradeState> emit) {
    emit(state.copyWith(order: state.order.copyWith(time: event.value)));
  }

  onSetPointOrder(SetOrderPointEvent event, Emitter<TradeState> emit) {
    emit(
      state.copyWith(
        order: state.order.copyWith(price: event.point),
      ),
    );
  }

  onStopOrder(StopOrderEvent event, Emitter<TradeState> emit) async {
    final orders = {...state.activeOrders};
    final order = orders.remove(event.id);
    emit(state.copyWith(activeOrders: orders));
    if (order == null) return;
    final x = await ApiClentTrade.getCourse(
        time: DateTime.now().subtract(const Duration(minutes: 30)),
        valute: order.valute);
    emit(state.copyWith(charts: x));
    final result = (x.last.close as double) > order.cost;
    if (result == order.promise) {
      final newHistory = [
        ...state.history,
      ];
      newHistory.insert(0, (order.copyWith(status: MyStatus.win)));

      emit(state.copyWith(history: newHistory));
      emit(state.copyWith(
        status: MyStatus.win,
        user:
            state.user.copyWith(points: state.user.points + (order.price * 2)),
      ));
      await repo.saveUserPoints(
          point: state.user.points, login: state.user.login);
      await repo.saveOrder(order: order.copyWith(status: MyStatus.win));

      emit(state.copyWith(status: MyStatus.initial));
    } else {
      final newHistory = [
        ...state.history,
      ];
      newHistory.insert(0, (order.copyWith(status: MyStatus.lose)));
      emit(state.copyWith(history: newHistory));
      emit(state.copyWith(
        status: MyStatus.lose,
      ));
      repo.saveOrder(order: order.copyWith(status: MyStatus.lose));

      final newActive = {...state.activeOrders};
      newActive.remove(event.id);
      if (state.user.points < 50) {
        emit(state.copyWith(status: MyStatus.zero));
      }
      emit(state.copyWith(status: MyStatus.initial));
    }
  }

  onChangeCurrentValute(ChangeCurrentValute event, Emitter<TradeState> emit) {
    emit(state.copyWith(
        priceModel:
            state.priceModel.copyWith(currentValute: event.currentValute),
        calculateData: state.calculateData.copyWith(calcResult: 0)));
  }

  onChangeCurrentPrice(ChangeCurrentPrice event, Emitter<TradeState> emit) {
    emit(state.copyWith(
        priceModel:
            state.priceModel.copyWith(currentPrice: event.currentPrice)));
  }

  onChangeCurrentTime(ChangeCurrentTime event, Emitter<TradeState> emit) {
    emit(state.copyWith(
        priceModel: state.priceModel.copyWith(currentTime: event.currentTime)));
  }

  onCalculateValute(
      CalculateValuteEvent event, Emitter<TradeState> emit) async {
    if (event.value == null) {
      return emit(state.copyWith(
          calculateData: state.calculateData.copyWith(calcResult: 0)));
    }
    if (state.priceModel.currentValute ==
        state.calculateData.lastCurrentValute) {
      final price = state.charts.last.close as double;
      final result = event.value! * price;
      return emit(state.copyWith(
          calculateData: state.calculateData.copyWith(calcResult: result)));
    }
    try {
      final list = await ApiClentTrade.getCourse(
          valute: state.priceModel.currentValute,
          time: DateTime.now().subtract(const Duration(minutes: 30)));

      emit(state.copyWith(
          charts: list,
          calculateData: state.calculateData
              .copyWith(lastCurrentValute: state.priceModel.currentValute)));
      final opens = list.first.open;
      if (!list.any((element) => element.open != opens)) {
        emit(state.copyWith(isWorker: false));
      }
    } catch (e) {
      emit(state.copyWith(charts: []));
    }
    final price = state.charts.last.close as double;
    final result = event.value! * price;
    emit(state.copyWith(
        calculateData: state.calculateData.copyWith(calcResult: result)));
  }
}
