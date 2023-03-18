import 'package:dio/dio.dart';
import '../../../const/app_const.dart';

class NetworkLocation {
  final dio = Dio();

  NetworkLocation() {
    dio.options = BaseOptions(
      baseUrl: AppConst.locationUrl,
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}