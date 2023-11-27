// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trade_bloc.dart';

abstract class TradeEvent {}

class AddOrderEvent extends TradeEvent {
  final bool value;
  AddOrderEvent({
    required this.value,
  });
}

class SetOrderTimeEvent extends TradeEvent {
  final int value;
  SetOrderTimeEvent({
    required this.value,
  });
}

class SetOrderPointEvent extends TradeEvent {
  final int point;
  SetOrderPointEvent({
    required this.point,
  });
}

class StopOrderEvent extends TradeEvent {
  final String id;
  StopOrderEvent({
    required this.id,
  });
}

class ChangeValuteList extends TradeEvent {
  final int index;
  ChangeValuteList({
    required this.index,
  });
}

class GetHistoryEvent extends TradeEvent {}

class GetValuteList extends TradeEvent {}

class ResetAllEvent extends TradeEvent {}

class GetCurrentChartsEvent extends TradeEvent {}

class GetTimerUpdateChartEvent extends TradeEvent {}

class ChangeCurrentTime extends TradeEvent {
  final int currentTime;
  ChangeCurrentTime({
    required this.currentTime,
  });
}

class CalculateValuteEvent extends TradeEvent {
  final double? value;
  CalculateValuteEvent({
    required this.value,
  });
}

class BonusLessonPointsEvent extends TradeEvent {
  final double bonus;
  BonusLessonPointsEvent({
    required this.bonus,
  });
}

class GetTradeUserEvent extends TradeEvent {
  final MyUser user;
  GetTradeUserEvent({
    required this.user,
  });
}

class ChangeCurrentPrice extends TradeEvent {
  final int currentPrice;
  ChangeCurrentPrice({
    required this.currentPrice,
  });
}

class ChangeCurrentValute extends TradeEvent {
  final String currentValute;
  ChangeCurrentValute({
    required this.currentValute,
  });
}

class ChangeIsAHistoryEvent extends TradeEvent {
  final bool isActiveH;
  ChangeIsAHistoryEvent({
    required this.isActiveH,
  });
}
