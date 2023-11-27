// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trade_bloc.dart';

class TradeState {
  final Map<String, MyOrder> activeOrders;
  final MyStatus status;
  final PriceModel priceModel;
  final MyUser user;
  final CalculateData calculateData;
  final bool isActiveH;
  final List<ChartSampleData> charts;
  final MyOrder order;
  final List<MyOrder> history;
  final bool isWorker;
  const TradeState({
    required this.user,
    this.isActiveH = true,
    this.priceModel = const PriceModel(),
    this.status = MyStatus.initial,
    this.activeOrders = const {},
    this.charts = const [],
    this.calculateData = const CalculateData(),
    required this.order,
    this.history = const [],
    this.isWorker = true,
  });

  double get cost {
    return charts.last.close as double;
  }

  TradeState copyWith({
    Map<String, MyOrder>? activeOrders,
    MyStatus? status,
    PriceModel? priceModel,
    MyUser? user,
    bool? isActiveH,
    List<ChartSampleData>? charts,
    MyOrder? order,
    List<MyOrder>? history,
    CalculateData? calculateData,
    bool? isWorker,
  }) {
    return TradeState(
      user: user ?? this.user,
      activeOrders: activeOrders ?? this.activeOrders,
      status: status ?? this.status,
      isActiveH: isActiveH ?? this.isActiveH,
      calculateData: calculateData ?? this.calculateData,
      charts: charts ?? this.charts,
      order: order ?? this.order,
      priceModel: priceModel ?? this.priceModel,
      history: history ?? this.history,
      isWorker: isWorker ?? this.isWorker,
    );
  }
}
