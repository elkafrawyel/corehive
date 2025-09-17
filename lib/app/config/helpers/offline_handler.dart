import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../presentation/widgets/app_modal_bottom_sheet.dart';
import '../../presentation/widgets/app_text.dart';
import 'logging_helper.dart';

class OfflineHandler {
  static bool _dialogOpened = false;

  static Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult = (await Connectivity()
        .checkConnectivity());
    if (connectivityResult.first == ConnectivityResult.mobile) {
      AppLogger.log('Connected to Mobile Network');
      return true;
    } else if (connectivityResult.first == ConnectivityResult.wifi) {
      AppLogger.log('Connected to WiFi');
      return true;
    } else {
      AppLogger.log('No internet connection');
      return false;
    }
  }

  static handle() async {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> connectivityResult,
    ) {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        _hideGetXDialog();
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        _hideGetXDialog();
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        _hideGetXDialog();
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        _showNoConnectionDialog();
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        _showNoConnectionDialog();
      } else {
        _showNoConnectionDialog();
      }
    });
  }

  static _hideGetXDialog() {
    if (_dialogOpened) {
      Get.back();
      _dialogOpened = false;
      AppLogger.log('Your connection was established');
    }
  }

  static _showNoConnectionDialog() async {
    if (_dialogOpened) {
      return;
    }

    await showAppModalBottomSheet(
      context: Get.context!,
      child: Center(child: AppText(text: 'Your connection was lost')),
    );
    _dialogOpened = true;
    AppLogger.log('Your connection was lost', level: Level.error);
  }
}
