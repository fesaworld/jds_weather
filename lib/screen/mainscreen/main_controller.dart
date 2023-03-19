import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_controller.dart';
import '../../data/model/city_model.dart';
import '../../data/model/prov_model.dart';
import '../../data/model/weather_5day_model.dart';
import '../../data/model/weather_now_model.dart';
import '../../widget/dialog/exception_dialog_widget.dart';
import '../../widget/dialog/loading_dialog_widget.dart';
import '../weatherscreen/weather_screen.dart';

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

      Get.back();
      update();
      return response;
    } catch (e) {
      Get.back();

      String message;
      if (e.toString() == 'Throw of null.') {
        message = 'No Internet';
      } else {
        message = e.toString();
      }
      exceptionDialog(message);
    }
  }

  Future getCity(String idProv) async {
    try {
      var response = await repository.cityGet(idProv);
      cityModel = response;
      update();
      return response;
    } catch (e) {
      String message;
      if (e.toString() == 'Throw of null.') {
        message = 'No Internet';
      } else {
        message = e.toString();
      }
      exceptionDialog(message);
    }
  }

  Future getWeather({required String city, required String name}) async {
    try {
      loadingDialog();

      String _city = city!.replaceAll('Kota ', '');
      _city = _city.replaceAll('Kabupaten ', '');

      var responseNow = await repository.weatherNowGet(_city);
      weatherNowModel = responseNow;

      var response5Day = await repository.weather5DayGet(_city);
      weather5dayModel = response5Day;

      Get.back();
      Get.to(() => const WeatherScreen(), arguments: [name, weatherNowModel, weather5dayModel]);

      update();
    } catch (e) {
      Get.back();

      String message;
      if (e.toString() == 'Throw of null.') {
        message = 'No Internet';
      } else {
        message = e.toString();
      }
      exceptionDialog(message);
    }
  }

  void loadingDialog(){
    Get.dialog(
        barrierDismissible: false,
        const LoadingDialogWidget()
    );
  }

  void exceptionDialog(String message){
    Get.dialog(
      ExceptionDialogWidget(
        message: message,
        onPressed: () {
          Get.back();
        },)
    );
  }

  void onRefresh() {
    nameController.text = '';
    selectedProvId = null;
    selectedProv = null;
    selectedCityId = null;
    selectedCity = null;

    visibilityName = false;
    visibilityProv = false;
    visibilityCity = false;
    update();

    getProv();
    loadingDialog();
  }
}