import 'dart:async';
import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/trade/domain/model/order.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseTradeRepo with PrefOrder {
  Future<void> saveOrder({required MyOrder order});
  Future<List<MyOrder>> getHistoryOrder();
  Future<void> resete();
}

mixin PrefOrder {
  final String points = 'points';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  Future<int> orderInit({required int price, required MyUser user}) async {
    final p = user.points - price;
    (await prefs).setInt('${user.login}$points', p);
    return p;
  }

  Future<int> orderWin({required int price, required MyUser user}) async {
    final p = user.points + (price * 2);
    (await prefs).setInt('${user.login}$points', p);
    return p;
  }

  Future<void> saveUserPoints(
      {required int point, required String login}) async {
    (await prefs).setInt(login + points, point);
  }
}

class TradeRepo extends BaseTradeRepo {
  final Isar isar;
  final StreamController<String> errorController;
  TradeRepo({required this.errorController, required this.isar});
  @override
  Future<List<MyOrder>> getHistoryOrder() async {
    final items = await isar.isarOrders.where().findAll();
    final history = <MyOrder>[];
    items.map(
      (e) {
        history.add(
          MyOrder(
            myId: e.myId!,
            status: e.status,
            price: e.price!,
            date: e.date!,
            time: e.time!,
            cost: e.cost!,
            valute: e.valute!,
            isActive: e.isActive!,
            promise: e.promise!,
          ),
        );
      },
    ).toList();
    return history;
  }

  @override
  Future<void> resete() async {
    await isar.writeTxn(() async {
      await isar.isarOrders.clear();
    });
  }

  @override
  Future<void> saveOrder({required MyOrder order}) async {
    final isarOrder = IsarOrder()
      ..cost = order.cost
      ..myId = order.myId
      ..isActive = order.isActive
      ..price = order.price
      ..status = order.status
      ..time = order.time
      ..date = order.date
      ..valute = order.valute
      ..promise = order.promise;
    isar.writeTxn(() async {
      isar.isarOrders.put(isarOrder);
    });
  }
}
