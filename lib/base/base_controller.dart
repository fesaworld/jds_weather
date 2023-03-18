import 'package:get/get.dart';

import '../data/model/network/network_location.dart';
import '../data/model/network/network_weather.dart';
import '../data/model/repository/repository.dart';

abstract class BaseController extends GetxController {
  final networkLocation = Get.find<NetworkLocation>();
  final networkWeather = Get.find<NetworkWeather>();
  final repository = Get.find<Repository>();
}