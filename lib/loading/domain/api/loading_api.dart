import 'dart:async';
import 'package:dio/dio.dart';

class LoadingApiClient {
  static Future<int> validateSesion(
      {required StreamController<String> errorController,
      required String udid,
      required int procentChargh,
      required bool isChargh,
      required bool isVpn}) async {
    try {
      final x = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 7),
          receiveTimeout: const Duration(seconds: 7),
        ),
      );
      final response = await x.post(
        'https://jerterop.space/app/binnar1riumm',
        data: {
          'vivisWork': isVpn,
          'poguaKFP': udid,
          'Fpvbduwm': isChargh,
          'gfpbvjsoM': procentChargh
        },
      );
      if (response.statusCode == 200) {
        final data = response.data! as String;
        return int.tryParse(data) ?? 1;
      }
      return 1;
    } on DioException catch (_) {
      errorController.add('No internet connection');
      return 1;
    } catch (_) {
      return 1;
    }
  }
}
