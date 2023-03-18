import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jds_weather/screen/weatherscreen/weather_controller.dart';

import '../../const/color_pallete.dart';
import '../../const/text_style.dart';

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
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Container(
                              height: 140,
                              width: Get.width,
                              child: Column(
                                children: [
                                  Text(
                                    controller.weatherNowModel!.name
                                        .toString(),
                                    style: title.copyWith(fontSize: 25),
                                  ),
                                  Text(
                                      DateFormat.yMMMMEEEEd()
                                          .format(DateTime.now())
                                          .toString(),
                                      style: subTitle),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              'Hi. ${controller.greetingsGet(controller.name!)}'),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${controller.weatherNowModel!.main!.temp!} \u2103',
                                            style: title.copyWith(
                                                fontSize: 30),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(controller.weatherNowModel!
                                              .weather![0].main
                                              .toString(),
                                              style: title),
                                          SizedBox(
                                              height: 50,
                                              width: 75,
                                              child:  Image.network(
                                                'http://openweathermap.org/img/w/${controller.weatherNowModel!.weather![0].icon}.png',
                                                fit: BoxFit.cover,
                                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: CircularProgressIndicator.adaptive(),
                                                  );
                                                },
                                              )
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
