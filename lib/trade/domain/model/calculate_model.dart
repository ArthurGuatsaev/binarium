class CalculateData {
  final List<String> valuteList;
  final double calcResult;
  final String lastCurrentValute;
  final String favoriteValute;
  const CalculateData(
      {this.valuteList = const [],
      this.calcResult = 0,
      this.lastCurrentValute = '',
      this.favoriteValute = ''});

  CalculateData copyWith({
    List<String>? valuteList,
    String? favoriteValute,
    double? calcResult,
    String? lastCurrentValute,
  }) {
    return CalculateData(
      valuteList: valuteList ?? this.valuteList,
      favoriteValute: favoriteValute ?? this.favoriteValute,
      calcResult: calcResult ?? this.calcResult,
      lastCurrentValute: lastCurrentValute ?? this.lastCurrentValute,
    );
  }
}
