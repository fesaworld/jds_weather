import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jds_weather/const/text_style.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        content: Container(
            height: 150,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(
                  height: 20,
                ),
                Text('Mohon tunggu', style: title)
              ],
            )),
      ),
    );
  }
}
