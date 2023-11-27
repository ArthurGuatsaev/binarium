import 'package:binarium/trade/domain/model/charts_model.dart';
import 'package:dio/dio.dart';

class ApiClentTrade {
  static Future<List<ChartSampleData>> getCourse(
      {required String valute, required DateTime time}) async {
    try {
      const token = '93af830c-2c48-46f0-b831-b248a6b20bb1';
      final x = await Dio().get<Map<String, dynamic>>(
          'https://basasrt.space/api/v2/currencies?pairs=$valute&startAt=${time.day}.${time.month}.${time.year} ${time.hour}:${time.minute}&token=$token');
      if (x.statusCode == 200) {
        final chart = x.data!['results'] as List<dynamic>;
        final newChart = chart.map((e) => e as Map<String, dynamic>).toList();
        num? openPrice;
        final list = newChart.map((e) {
          final x = ChartSampleData.fromMap(e, openPrice);
          openPrice = e['resultPrice'];
          return x;
        }).toList();
        return list;
      }
      return [];
    } catch (e) {
      print('chart');
      return [];
    }
  }
}
