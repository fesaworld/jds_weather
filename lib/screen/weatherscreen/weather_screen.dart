import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jds_weather/screen/weatherscreen/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
        init: WeatherController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Text('This screen 2'),
            ),
          );
        });
  }
}
