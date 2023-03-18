import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jds_weather/screen/splashscreen/splash_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
              child: Text(
                  'Weather App',
                  style: GoogleFonts.karla(fontSize: 20, fontWeight: FontWeight.w700)
              )
          ),
        );
      },
    );
  }
}