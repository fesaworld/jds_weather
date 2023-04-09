import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jds_weather/data/model/weather_now_model.dart';

import '../../base/base_controller.dart';
import '../../data/model/weather_5day_model.dart';
import '../../widget/dialog/exception_dialog_widget.dart';
import '../../widget/dialog/loading_dialog_widget.dart';

class WeatherController extends BaseController {
  String? name;
  String? city;
  bool isMetric = true;
  WeatherNowModel? weatherNowModel;
  Weather5DayModel? weather5dayModel;

  bool buttonVisible = true;
  ScrollController scrollController = ScrollController();

  List<List<Map<String, dynamic>>>  dateData = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    name = Get.arguments[0];
    city = Get.arguments[1];
    weatherNowModel = Get.arguments[2];
    weather5dayModel = Get.arguments[3];

    scrollController.addListener(() {
      if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
        buttonVisible = false;
      }
      // if(scrollController.position.userScrollDirection == ScrollDirection.forward){
      if (scrollController.position.pixels == 0) {
        buttonVisible = true;
      }
      // }
      update();
    });

    filters();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    scrollController.dispose();
    scrollController.removeListener(() { });
  }

  String greetingsGet(String name) {
    int hour = DateTime.now().hour;
    String greetings = '';
    if (hour >= 0 && hour < 10){
      greetings = 'Selamat pagi, $name';
    } else if (hour >= 10 && hour < 16) {
      greetings = 'Selamat siang, $name';
    } else if (hour >= 16 && hour < 18) {
      greetings = 'Selamat sore, $name';
    } else {
      greetings = 'Selamat Malam, $name';
    }
    return greetings;
  }

  void filters() {
    dateData.clear();
    String date = '';
    int indexOne = 0;
    for(var data in weather5dayModel!.list!) {
      if (indexOne == 0 || DateFormat.Md().format(DateTime.parse(data.dtTxt!)) != date){
        date = DateFormat.Md().format(DateTime.parse(data.dtTxt!));

        dateData.insert(indexOne, []);

        for(var datas in weather5dayModel!.list!) {
          if (DateFormat.Md().format(DateTime.parse(datas.dtTxt!)) == date) {

            dateData[indexOne].add({
              'date' : datas.dtTxt,
              'icon' : datas.weather![0].icon,
              'temp' : datas.main!.temp,
            });

          }
        }
        indexOne++;
      }
    }
  }

  Future updateTemp({required String city, required String temp}) async {
    try {
      loadingDialog();

      var responseNow = await repository.weatherNowGet(city, temp);
      weatherNowModel = responseNow;

      var response5Day = await repository.weather5DayGet(city, temp);
      weather5dayModel = response5Day;

      Get.back();
      filters();

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
}