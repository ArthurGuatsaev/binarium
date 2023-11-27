import 'dart:async';
import 'package:isar/isar.dart';

part 'order.g.dart';

class MyOrder {
  final String myId;
  final MyStatus status;
  final int price;
  final DateTime date;
  final int time;
  final double cost;
  final String valute;
  final bool isActive;
  final bool promise;
  MyOrder({
    required this.myId,
    required this.status,
    required this.price,
    required this.date,
    required this.time,
    required this.cost,
    required this.valute,
    required this.isActive,
    required this.promise,
  });
  MyOrder.initial(
      {this.price = 50,
      this.time = 0,
      this.cost = 0,
      this.isActive = false,
      this.valute = 'EURUSD',
      this.promise = false,
      this.status = MyStatus.initial,
      this.myId = ''})
      : date = DateTime(2023);
  DateTime get dealTime {
    return date;
  }

  // DateTime substract() {
  //   final minutes = int.tryParse(time.substring(0, index));
  //   final seconds = int.tryParse(time.substring(index + 1));
  //   final deal = DateTime(2023, 1, 1, 1, minutes ?? 0, seconds ?? 0);
  //   return deal;
  // }

  String get dealTimeString {
    final hours = '${dealTime.hour}'.length < 2
        ? '0${dealTime.hour}'
        : '${dealTime.hour}';
    final minute = '${dealTime.minute}'.length < 2
        ? '0${dealTime.minute}'
        : '${dealTime.minute}';
    return '$hours:$minute';
  }

  Stream<String> timerSubstruct() async* {
    String result = '';
    int tick = 1;
    while (tick >= 0) {
      if (tick != 1) {
        await Future.delayed(const Duration(seconds: 1));
      }
      final left = date.difference(DateTime.now()) + Duration(seconds: time);
      tick = left.inSeconds;
      int minute = 0;
      int second = 0;
      if (left.inSeconds < 0) {
        yield '00:00';
      } else {
        if (left.inMinutes >= 1) {
          minute = left.inMinutes;
          second = left.inSeconds - minute * 60;
        } else {
          second = left.inSeconds;
        }
        final min = '$minute'.length < 2 ? '0$minute' : '$minute';
        final sec = '$second'.length < 2 ? '0$second' : '$second';
        result = '$min:$sec';
        yield result;
      }
    }
  }

  // Duration get timer {
  //   final index = time.indexOf(':');
  //   final minutes = time.substring(0, index);
  //   final seconds = time.substring(index + 1);
  //   return Duration(minutes: int.parse(minutes), seconds: int.parse(seconds));
  // }

  MyOrder copyWith({
    String? myId,
    MyStatus? status,
    int? price,
    DateTime? date,
    int? time,
    double? cost,
    String? valute,
    bool? isActive,
    bool? promise,
  }) {
    return MyOrder(
      myId: myId ?? this.myId,
      status: status ?? this.status,
      price: price ?? this.price,
      date: date ?? this.date,
      time: time ?? this.time,
      cost: cost ?? this.cost,
      valute: valute ?? this.valute,
      isActive: isActive ?? this.isActive,
      promise: promise ?? this.promise,
    );
  }

  @override
  String toString() {
    return 'MyOrder(myId: $myId, status: $status, price: $price, date: $date, time: $time, cost: $cost, valute: $valute, isActive: $isActive, promise: $promise)';
  }

  @override
  bool operator ==(covariant MyOrder other) {
    if (identical(this, other)) return true;

    return other.myId == myId &&
        other.status == status &&
        other.price == price &&
        other.date == date &&
        other.time == time &&
        other.cost == cost &&
        other.valute == valute &&
        other.isActive == isActive &&
        other.promise == promise;
  }

  @override
  int get hashCode {
    return myId.hashCode ^
        status.hashCode ^
        price.hashCode ^
        date.hashCode ^
        time.hashCode ^
        cost.hashCode ^
        valute.hashCode ^
        isActive.hashCode ^
        promise.hashCode;
  }
}

@collection
class IsarOrder {
  Id id = Isar.autoIncrement;
  String? myId;
  @enumerated
  MyStatus status = MyStatus.initial;
  int? price;
  DateTime? date;
  int? time;
  double? cost;
  String? valute;
  bool? isActive;
  bool? promise;
}

enum MyStatus { initial, win, lose, error, zero }
