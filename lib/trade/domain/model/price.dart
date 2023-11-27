class PriceModel {
  final String currentValute;
  final int currentPrice;
  final int currentTime;
  const PriceModel({
    this.currentValute = 'EURUSD',
    this.currentPrice = 0,
    this.currentTime = 0,
  });

  PriceModel copyWith({
    String? currentValute,
    int? currentPrice,
    int? currentTime,
  }) {
    return PriceModel(
      currentValute: currentValute ?? this.currentValute,
      currentPrice: currentPrice ?? this.currentPrice,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  String get fromValute {
    return currentValute.substring(0, 3);
  }

  String get toValute {
    return currentValute.substring(3, 6);
  }

  @override
  String toString() =>
      'PriceModel(currentValute: $currentValute, currentPrice: $currentPrice, currentTime: $currentTime)';

  @override
  bool operator ==(covariant PriceModel other) {
    if (identical(this, other)) return true;

    return other.currentValute == currentValute &&
        other.currentPrice == currentPrice &&
        other.currentTime == currentTime;
  }

  @override
  int get hashCode =>
      currentValute.hashCode ^ currentPrice.hashCode ^ currentTime.hashCode;
}
