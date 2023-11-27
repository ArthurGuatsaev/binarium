import 'dart:async';

import 'package:binarium/lessons/data/lessons_api.dart';
import 'package:binarium/lessons/model/lesson.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';

class LessonsRepo {
  final StreamController<String> errorController;
  LessonsRepo({required this.errorController});
  List<Lesson>? lessons;
  Future<void> getLessons(
      {required StreamController<VLoading> controller}) async {
    lessons = await LessonApiClient.getLessons(errorController);
    controller.add(VLoading.lessons);
  }
}
