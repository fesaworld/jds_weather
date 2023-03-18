import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jds_weather/screen/splashscreen/splash_screen.dart';

import 'binding/global_binding.dart';
import 'const/text_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();

  var connectivityResult = await (Connectivity().checkConnectivity());
  print('object');
  print(connectivityResult);
  if (connectivityResult == ConnectivityResult.none) {
    runApp(const NoInternet());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            fontFamily: GoogleFonts.karla().fontFamily
        ),
        home: const SplashScreen()
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: GoogleFonts.karla().fontFamily,
      ),
      home: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off,size: 100,),
              Text(
                'No Internet',
                style: title.copyWith(fontSize: 25),
              ),
              Text(
                '"connect to network to open this app"',
                style: subTitle.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
