import 'dart:async';

import '../../base/base_controller.dart';

class SplashController extends BaseController {

  @override
  void onInit() {
    super.onInit();

    timerStart();
  }

  void timerStart() async {
    Timer(const Duration(seconds: 3), () async {

    });
  }

}