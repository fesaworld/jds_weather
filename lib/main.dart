import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jds_weather/screen/splashscreen/splash_screen.dart';

import 'binding/global_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();
  runApp(const MyApp());
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
