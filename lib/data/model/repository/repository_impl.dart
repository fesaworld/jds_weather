import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jds_weather/data/model/repository/repository.dart';

import '../network/network_location.dart';
import '../network/network_weather.dart';
import '../prov_model.dart';
import '../city_model.dart';
import '../weather_5day_model.dart';
import '../weather_now_model.dart';

class RepositoryImpl implements Repository {
  final networkLocation = Get.find<NetworkLocation>();
  final networkWeather = Get.find<NetworkWeather>();

  final String key = "9b53d369b79c0c5c5f46674e635ffd06";

  @override
  Future<ProvModel?> provGet() async {
    try {
      final response = await networkLocation.dio.get('/api/daerahindonesia/provinsi');
      return ProvModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data?['message'];
    }
  }

  @override
  Future<CityModel?> cityGet(String idProv) async {
    try {
      final response = await networkLocation.dio.get('/api/daerahindonesia/kota?id_provinsi=$idProv');
      return CityModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data?['message'];
    }
  }

  @override
  Future<WeatherNowModel?> weatherNowGet(String city) async {
    try {
      final response = await networkWeather.dio.get('/data/2.5/weather?q=$city&appid=$key&units=metric');
      return WeatherNowModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data?['message'];
    }
  }

  @override
  Future<Weather5DayModel?> weather5DayGet(String city) async {
    try {
      final response = await networkWeather.dio.get('/data/2.5/forecast?q=$city&appid=$key&units=metric');
      return Weather5DayModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data?['message'];
    }
  }
}