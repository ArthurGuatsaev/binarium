import 'dart:async';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:apphud/apphud.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class VServices {
  final String apphudApiKey = 'app_tkdEa4ZaPPNKbMWhLT2bsS9KPRtxaQ';
  final String amplitudeApiKey = 'a71d42a30040041e4df2520425f15abb';
  final String userId = '';
  Future<void> initApphud(
      {required StreamController<VLoading> controller}) async {
    await Apphud.start(
        apiKey: apphudApiKey, observerMode: false, userID: userId);
    controller.add(VLoading.apphud);
  }

  Future<void> initAmplitude(
      {required StreamController<VLoading> controller}) async {
    final analytics =
        Amplitude.getInstance(instanceName: 'a71d42a30040041e4df2520425f15abb');
    await analytics.init(amplitudeApiKey);
    await analytics.trackingSessionEvents(true);
    await analytics.setUserId(userId);
    controller.add(VLoading.amplitude);
  }

  Future<void> initOneSignal() async {
    OneSignal.initialize("");
  }
}
