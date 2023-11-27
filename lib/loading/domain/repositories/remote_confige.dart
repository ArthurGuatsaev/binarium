// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';

class FirebaseRemote {
  final StreamController<String> errorController;
  FirebaseRemote({required this.errorController});
  bool isDead = false;
  bool needTg = false;
  String tg = 'https://telegram.me/';
  String url = '';
  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initialize({
    required StreamController<VLoading> streamController,
    required String userId,
  }) async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(seconds: 1)),
      );
      streamController.add(VLoading.initRemote);
      await remoteConfig.setDefaults(const {
        "info": "https://google.com",
        "isDead": false,
        "needTg": false,
        "tg": 'https://telegram.me/'
      });

      await remoteConfig.fetchAndActivate();
      url = remoteConfig.getString('info');
      isDead = remoteConfig.getBool('isDead');
      tg = remoteConfig.getString('tg');
      isDead = remoteConfig.getBool('isDead');
      needTg = remoteConfig.getBool('needTg');
      // url = updateUrl(url: initialUrl, id: userId);
      if (needTg) {
        streamController.add(VLoading.tgTrue);
      } else {
        streamController.add(VLoading.tgFalse);
      }
      streamController.add(VLoading.remoteActivate);
    } catch (e) {
      streamController.add(VLoading.remoteActivate);
      errorController.add('No internet connection');
    }
  }

  String getUrl() {
    try {
      return remoteConfig.getString('info');
    } catch (e) {
      throw FirebaseRemoteExeption(message: 'firebase remoute exeption');
    }
  }

  String updateUrl({required String url, required String userId}) {
    //генерируем id (Apphud.userId())
    // final id = '=${Random().nextInt(1000000)}-${DateTime.now().millisecond}';
    const click = 'click_id';
    //проверяем есть ли click_id, если есть то вставляем сразу после него рандомный id;
    if (url.contains(click)) {
      final index = url.indexOf(click);
      final before = url.substring(0, index + 8);
      return before + userId;
    } else {
      // если нет то вставляем нужный символ и добавляем click_id=id
      final separator = url.contains('?') ? '&' : '?';
      return url + separator + click + userId;
    }
  }
}

class FirebaseRemoteExeption implements Exception {
  final String message;
  FirebaseRemoteExeption({
    required this.message,
  });
}
