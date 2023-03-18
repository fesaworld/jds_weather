import 'package:get/get.dart';

import '../data/model/network/network_location.dart';
import '../data/model/network/network_weather.dart';
import '../data/model/repository/repository.dart';
import '../data/model/repository/repository_impl.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkLocation>(NetworkLocation(), permanent: true);
    Get.put<NetworkWeather>(NetworkWeather(), permanent: true);
    Get.put<Repository>(RepositoryImpl(), permanent: true);
  }
}