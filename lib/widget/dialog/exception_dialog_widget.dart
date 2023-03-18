import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/color_pallete.dart';
import '../../const/text_style.dart';

class ExceptionDialogWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String message;
  const ExceptionDialogWidget({Key? key, required this.onPressed, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Terjadi kesalahan',style: title),
      content: Text(message, style: subTitle.copyWith(fontSize: 16)),
      actions: [
        Container(
          padding: EdgeInsets.all(12),
          width: Get.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.secondary,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: ColorPalette.lines,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(8))),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                  'Oke',
                  style: title.copyWith(color: ColorPalette.white)
              ),
            ),
          ),
        )
      ],
    );
  }
}
