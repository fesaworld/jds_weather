import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jds_weather/screen/weatherscreen/weather_controller.dart';

import '../../const/color_pallete.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
        init: WeatherController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    image: DecorationImage(
                        image: AssetImage('assets/image/background.jpg'),
                        fit: BoxFit.fitHeight)),
                child: Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Visibility(
                        visible: controller.buttonVisible,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.arrow_back,
                            color: ColorPalette.body,
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
