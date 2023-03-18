import 'package:get/get.dart';
import 'package:jds_weather/data/model/repository/repository.dart';

import '../network/network_location.dart';
import '../network/network_weather.dart';

class RepositoryImpl implements Repository {
  final networkLocation = Get.find<NetworkLocation>();
  final networkWeather = Get.find<NetworkWeather>();


}