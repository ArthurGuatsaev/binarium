import 'dart:async';

import 'package:binarium/loading/domain/api/loading_api.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:binarium/loading/domain/repositories/shared_repo.dart';

class LoadingRepo with VSharedPref {
  final StreamController<String> errorController;
  LoadingRepo({required this.errorController});
  final date = DateTime(2023, 11, 30);
  Future<void> getIsFirstShow(
      {required StreamController<VLoading> controller}) async {
    final firstShow = (await prefs).getBool(show) ?? true;
    if (firstShow) {
      setFirstShow();
      controller.add(VLoading.firstShowTrue);
    } else {
      controller.add(VLoading.firstShowFalse);
    }
  }

  Future<void> isFinanseMode({
    required StreamController<VLoading> controller,
    required String udid,
    required int procentChargh,
    required bool isChargh,
    required bool isVpn,
    required bool isDead,
  }) async {
    if (date.difference(DateTime.now()).inHours < 0) {
      // print(date.difference(DateTime.now()).inHours);
      return controller.add(VLoading.finanseModeTrue);
    }
    if (isDead) {
      return controller.add(VLoading.finanseModeTrue);
    }
    final firstShowF = (await prefs).getBool(fs);
    if (firstShowF != null) {
      controller.add(VLoading.finanseModeFalse);
    } else {
      final x = await LoadingApiClient.validateSesion(
          errorController: errorController,
          udid: udid,
          procentChargh: procentChargh,
          isChargh: isChargh,
          isVpn: isVpn);
      final isFinanse = x == 0;
      if (isFinanse) {
        setFirstShowFinance();
        controller.add(VLoading.finanseModeTrue);
      } else {
        controller.add(VLoading.finanseModeFalse);
      }
    }
    // controller.add(VLoading.finanseModeTrue);
  }
}
