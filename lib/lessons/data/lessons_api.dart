import 'dart:async';

import 'package:binarium/lessons/model/lesson.dart';
import 'package:dio/dio.dart';

class LessonApiClient {
  static Future<List<Lesson>> getLessons(
      StreamController<String> errorController) async {
    try {
      final x = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 7),
        receiveTimeout: const Duration(seconds: 7),
      ));
      final response = await x.get(
          'https://jerterop.space/api/v2/lessons/?lang=en&token=b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d');
      if (response.statusCode == 200) {
        final lessons = response.data!['results'] as List<dynamic>;
        final newLesson =
            lessons.map((e) => e as Map<String, dynamic>).toList();
        final list = newLesson.map((e) {
          final term = Lesson.fromMap(e);
          return term;
        }).toList();
        return list;
      }
      return [];
    } on DioException catch (_) {
      errorController.add('No internet connection');
      return [];
    } catch (e) {
      return [];
    }
  }
}
