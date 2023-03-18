import 'package:dio/dio.dart';

import '../../../const/app_const.dart';

class NetworkWeather {
  final dio = Dio();

  NetworkWeather() {
    dio.options = BaseOptions(
      baseUrl: AppConst.weatherUrl,
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}