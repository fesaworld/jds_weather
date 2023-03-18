import 'package:flutter/cupertino.dart';

import '../../base/base_controller.dart';

class MainController extends BaseController {
  FocusNode nameFocus = FocusNode();
  final nameController = TextEditingController();

  String? selectedProvId;
  String? selectedProv;
  String? selectedCityId;
  String? selectedCity;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}