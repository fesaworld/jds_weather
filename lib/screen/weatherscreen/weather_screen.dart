import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jds_weather/screen/weatherscreen/weather_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/color_pallete.dart';
import '../../const/text_style.dart';
import '../../data/model/chart_model.dart';

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
                        fit: BoxFit.cover)),
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
                                            '${controller.weatherNowModel!.main!.temp!} ${controller.isMetric ?'\u2103' :'\u2109'}',
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
                            Container(
                              height: 110,
                              width: Get.width,
                              padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: ColorPalette.primary, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 1,
                                color: Colors.transparent,
                                shadowColor: ColorPalette.white,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/humidity_percentage_icon.svg',
                                            width: 30),
                                        Text(
                                          '${controller.weatherNowModel!.main!.humidity} %', style: title,),
                                        Text('Humidity'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/pressure_icon.svg',
                                            width: 30),
                                        Text(
                                          '${controller.weatherNowModel!.main!.pressure} hpa', style: title,),
                                        Text('Pressure'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/cloud_icon.svg',
                                            width: 30),
                                        Text(
                                          '${controller.weatherNowModel!.clouds!.all} %', style: title,),
                                        Text('Cloudiness'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/wind_icon.svg',
                                            width: 30),
                                        Text(
                                          '${controller.weatherNowModel!.wind!.gust.toString()} m/s', style: title,),
                                        Text('Wind'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: ColorPalette.primary, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 1,
                                color: Colors.transparent,
                                shadowColor: ColorPalette.white,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                  child: SizedBox(
                                    width: 140 * controller.dateData.length.toDouble(),
                                    height: 85 * controller.dateData.length.toDouble(),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: controller.dateData.length,
                                        itemBuilder: (context, indexOne){
                                          return Container(
                                            width: 85,
                                            height: 85,
                                            // color: Colors.red,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  width: 40,
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                      DateFormat.MEd().format(
                                                          DateTime.parse(controller.dateData[indexOne][0]['date'])
                                                      ).toString(),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: controller.dateData[indexOne].length,
                                                    itemBuilder: (context, indexTwo) {
                                                      return Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          height: 70,
                                                          width: 70,
                                                          // color: Colors.blue,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                DateFormat.Hm().format(
                                                                    DateTime.parse(controller.dateData[indexOne][indexTwo]['date'])
                                                                ).toString(),
                                                                style: title.copyWith(fontSize: 12),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                width: 40,
                                                                child: Image.network(
                                                                  'http://openweathermap.org/img/w/${
                                                                      controller.dateData[indexOne][indexTwo]['icon']
                                                                  }.png',
                                                                  fit: BoxFit.cover,
                                                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                    if (loadingProgress == null) {
                                                                      return child;
                                                                    }
                                                                    return Center(
                                                                      child: CircularProgressIndicator.adaptive(),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Text(
                                                                '${controller.dateData[indexOne][indexTwo]['temp']} ${controller.isMetric ?'\u2103' :'\u2109'}',
                                                                style: title.copyWith(fontSize: 12),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.chartData.length,
                                  itemBuilder: (context, indexChart) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      height: 360,
                                      width: Get.width,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: ColorPalette.primary, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 1,
                                        color: Colors.transparent,
                                        shadowColor: ColorPalette.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                DateFormat.yMMMMEEEEd()
                                                    .format(DateTime.parse(
                                                    controller.dateData[
                                                    indexChart]
                                                    [0]['date']))
                                                    .toString(),
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              primaryYAxis: NumericAxis(),
                                              tooltipBehavior: controller.tooltip,
                                              series: <ChartSeries<ChartData, String>>[
                                                ColumnSeries<ChartData, String>(
                                                    dataSource: controller.chartData[indexChart],
                                                    xValueMapper: (ChartData data, _) =>  DateFormat.Hm().format(DateTime.parse(data.xDate.toString())),
                                                    yValueMapper: (ChartData data, _) => data.yTemp,
                                                    name: 'Temp',
                                                    color: Color.fromRGBO(8, 142, 255, 1))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Visibility(
                        visible: controller.buttonVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorPalette.body,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            Row(
                              children: [
                                Text('\u2109'),
                                Switch(
                                  activeColor: Colors.purple,
                                  activeTrackColor: Colors.cyan,
                                  inactiveThumbColor: Colors.purple,
                                  inactiveTrackColor: Colors.cyan,
                                  value: controller.isMetric,
                                  onChanged: (value) {
                                    controller.isMetric = value;
                                    controller.update();

                                    controller.updateTemp(
                                        city: controller.city!,
                                        temp: value ? 'metric' : 'imperial'
                                    );
                                  },
                                ),
                                Text('\u2103'),
                              ],
                            )
                          ],
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
