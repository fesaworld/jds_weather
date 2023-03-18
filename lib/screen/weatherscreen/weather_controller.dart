import 'package:get/get.dart';
import 'package:jds_weather/data/model/weather_now_model.dart';

import '../../base/base_controller.dart';
import '../../data/model/weather_5day_model.dart';

class WeatherController extends BaseController {
  String? name;
  WeatherNowModel? weatherNowModel;
  Weather5DayModel? weather5dayModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    name = Get.arguments[0];
    weatherNowModel = Get.arguments[1];
    weather5dayModel = Get.arguments[2];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}