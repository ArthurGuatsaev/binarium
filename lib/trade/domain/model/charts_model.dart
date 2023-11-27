class ChartSampleData {
  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  factory ChartSampleData.fromMap(Map<String, dynamic> map, num? openPrice) {
    return ChartSampleData(
      x: map['resultAt'] != null ? (map['resultAt'] as String).toTime : null,
      open: openPrice ?? map['resultPrice'],
      close: map['resultPrice'] != null ? map['resultPrice'] as num : null,
      low: map['resultMin'] != null ? map['resultMin'] as num : null,
      high: map['resultMax'] != null ? map['resultMax'] as num : null,
    );
  }
}

extension on String {
  DateTime get toTime {
    final x = indexOf('2023') + 5;
    final hours = substring(x, x + 2);
    final minuts = substring(x + 3, x + 5);
    final seconds = substring(x + 6, x + 8);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, int.parse(hours),
        int.parse(minuts), int.parse(seconds));
  }
}
