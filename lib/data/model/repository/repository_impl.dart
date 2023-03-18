import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jds_weather/data/model/repository/repository.dart';

import '../network/network_location.dart';
import '../network/network_weather.dart';
import '../prov_model.dart';

class RepositoryImpl implements Repository {
  final networkLocation = Get.find<NetworkLocation>();
  final networkWeather = Get.find<NetworkWeather>();

  @override
  Future<ProvModel?> provGet() async {
    try {
      final response = await networkLocation.dio.get('/api/daerahindonesia/provinsi');
      return ProvModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

}