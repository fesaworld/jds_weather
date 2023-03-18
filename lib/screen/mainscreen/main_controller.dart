import 'package:flutter/cupertino.dart';

import '../../base/base_controller.dart';
import '../../data/model/city_model.dart';
import '../../data/model/prov_model.dart';

class MainController extends BaseController {
  FocusNode nameFocus = FocusNode();
  final nameController = TextEditingController();

  String? selectedProvId;
  String? selectedProv;
  String? selectedCityId;
  String? selectedCity;

  ProvModel? provModel;
  CityModel? cityModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProv();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  Future getProv() async {
    try {
      var response = await repository.provGet();
      provModel = response;
      update();
      return response;
    } catch (e) {
      print(e);
      print('Data Provinsi gagal diambil');
    }
  }

  Future getCity(String idProv) async {
    try {
      var response = await repository.cityGet(idProv);
      cityModel = response;
      update();
      return response;
    } catch (e) {
      print(e);
      print('Data Kabupaten/kota gagal diambil');
    }
  }
}