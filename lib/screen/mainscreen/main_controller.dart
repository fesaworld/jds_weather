import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../base/base_controller.dart';
import '../../data/model/city_model.dart';
import '../../data/model/prov_model.dart';
import '../../data/model/weather_5day_model.dart';
import '../../data/model/weather_now_model.dart';

class MainController extends BaseController {
  FocusNode nameFocus = FocusNode();
  final nameController = TextEditingController();

  String? selectedProvId;
  String? selectedProv;
  String? selectedCityId;
  String? selectedCity;

  ProvModel? provModel;
  CityModel? cityModel;
  WeatherNowModel? weatherNowModel;
  Weather5DayModel? weather5dayModel;

  bool visibilityName = false;
  bool visibilityProv = false;
  bool visibilityCity = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProv();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  Future getProv() async {
    try {
      var response = await repository.provGet();
      provModel = response;
      update();
      return response;
    } catch (e) {
      print(e);
      print('Data Provinsi gagal diambil');
    }
  }

  Future getCity(String idProv) async {
    try {
      var response = await repository.cityGet(idProv);
      cityModel = response;
      update();
      return response;
    } catch (e) {
      print(e);
      print('Data Kabupaten/kota gagal diambil');
    }
  }

  Future getWeather({required String city, required String name}) async {
    try {
      String _city = city!.replaceAll('Kota ', '');
      _city = _city.replaceAll('Kabupaten ', '');

      var responseNow = await repository.weatherNowGet(_city);
      weatherNowModel = responseNow;

      var response5Day = await repository.weather5DayGet(_city);
      weather5dayModel = response5Day;

      Get.showSnackbar(GetSnackBar(message: 'Get weather data Success..', duration: Duration(seconds: 3),));

      update();
    } catch (e) {
      print(e);
      print('Terjadi kesalahan dalam mengambil data weather');
    }
  }
}