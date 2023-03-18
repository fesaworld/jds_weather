import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

import '../../const/color_pallete.dart';
import '../../const/text_style.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.nameFocus.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Weather APP'),
              ),
              body: SafeArea(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  padding: EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('Nama', style: subTitle),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  focusNode: controller.nameFocus,
                                  autofocus: false,
                                  style: subTitle,
                                  keyboardType: TextInputType.text,
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    hintText:
                                    'Masukkan Nama Anda',
                                    hintStyle: subTitle.copyWith(color: ColorPalette.body.withOpacity(0.7)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    contentPadding: const EdgeInsets.all(12),
                                  ),
                                  onChanged: (name) {
                                    if (name.isEmpty) {
                                      controller.visibilityName = true;
                                    }else {
                                      controller.visibilityName = false;
                                    }
                                    controller.update();
                                  },
                                ),
                                Visibility(
                                  visible: controller.visibilityName,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: ColorPalette.danger,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          'Masukkan nama anda',
                                          style: subTitle.copyWith(fontSize: 12, color: ColorPalette.secondary.withOpacity(0.7)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('Provinsi', style: subTitle.copyWith(color: ColorPalette.body)),
                                const SizedBox(
                                  height: 5,
                                ),
                                SearchChoices.single(
                                  autofocus: false,
                                  items: controller.provModel != null
                                      ? controller.provModel!.provinsi!
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item.nama,
                                        child: Text(
                                            item.nama
                                                .toString(),
                                            style: subTitle),
                                      ))
                                      .toList()
                                      : const [],
                                  value: controller.selectedProv,
                                  hint: "Pilih Provinsi",
                                  style: subTitle,
                                  onChanged: (value) {
                                    for (var data in controller.provModel!.provinsi!) {
                                      if (value != null && value == data.nama){
                                        controller.selectedProvId = data.id.toString();
                                        controller.selectedProv = data.nama;

                                        controller.getCity(controller.selectedProvId.toString());

                                        controller.visibilityProv = false;
                                      }else if (value == null) {
                                        controller.selectedProvId = null;
                                        controller.selectedProv = null;

                                        controller.visibilityProv = true;
                                      }
                                    }
                                    controller.update();
                                  },
                                  dialogBox: false,
                                  isExpanded: true,
                                  clearIcon: Icon(Icons.close, color: ColorPalette.body),
                                  displayClearIcon:
                                  controller.selectedProv == null
                                      ? false
                                      : true,
                                  onClear: () {
                                    controller.selectedCityId = null;
                                    controller.selectedCity = null;

                                    controller.selectedProvId = null;
                                    controller.selectedProv = null;
                                    controller.update();
                                  },
                                  menuConstraints: BoxConstraints.tight(
                                      const Size.fromHeight(350)),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_rounded,
                                    size: 35,
                                    color: ColorPalette.body,
                                  ),
                                  searchInputDecoration:
                                  InputDecoration(
                                    hintText: 'Cari Provinsi..',
                                    hintStyle: subTitle.copyWith(color: ColorPalette.body.withOpacity(0.7)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    contentPadding:
                                    const EdgeInsets.all(12),
                                  ),
                                  fieldPresentationFn:
                                      (Widget fieldWidget,
                                      {bool? selectionIsValid}) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: ColorPalette.lines
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                8)),
                                        child: fieldWidget);
                                  },
                                  onTap: () {
                                    controller.nameFocus.unfocus();
                                  },
                                ),
                                Visibility(
                                  visible: controller.visibilityProv,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: ColorPalette.danger,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          'Silahkan pilih provinsi',
                                          style: subTitle.copyWith(fontSize: 12, color: ColorPalette.secondary.withOpacity(0.7)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('Kabupaten/Kota', style: subTitle.copyWith(color: ColorPalette.body),),
                                const SizedBox(
                                  height: 5,
                                ),
                                SearchChoices.single(
                                  autofocus: false,
                                  items: controller.cityModel != null
                                      ? controller.cityModel!.kotaKabupaten!
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item.nama,
                                        child: Text(
                                            item.nama
                                                .toString(),
                                            style: subTitle),
                                      ))
                                      .toList()
                                      : const [],
                                  value: controller.selectedCity,
                                  hint: "Pilih Kabupaten/Kota",
                                  style: subTitle,
                                  onChanged: (value) {
                                    for (var data in controller.cityModel!.kotaKabupaten!) {
                                      if (value != null && value == data.nama) {
                                        controller.selectedCityId = data.id.toString();
                                        controller.selectedCity = data.nama;

                                        controller.visibilityCity = false;
                                      } else if (value == null) {
                                        controller.selectedCityId = null;
                                        controller.selectedCity = null;

                                        controller.visibilityCity = true;
                                      }
                                    }
                                    controller.update();
                                  },
                                  dialogBox: false,
                                  isExpanded: true,
                                  clearIcon: Icon(Icons.close, color: ColorPalette.body),
                                  displayClearIcon:
                                  controller.selectedCity == null
                                      ? false
                                      : true,
                                  onClear: () {
                                    controller.selectedCityId = null;
                                    controller.selectedCity = null;
                                    controller.update();
                                  },
                                  menuConstraints: BoxConstraints.tight(
                                      const Size.fromHeight(350)),
                                  icon: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      size: 35,
                                      color: ColorPalette.body
                                  ),
                                  searchInputDecoration:
                                  InputDecoration(
                                    hintText: 'Cari Kabupaten..',
                                    hintStyle: subTitle.copyWith(color: ColorPalette.body.withOpacity(0.7)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    contentPadding:
                                    const EdgeInsets.all(12),
                                  ),
                                  fieldPresentationFn:
                                      (Widget fieldWidget,
                                      {bool? selectionIsValid}) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: ColorPalette.lines
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                8)),
                                        child: fieldWidget);
                                  },
                                  onTap: () {
                                    controller.nameFocus.unfocus();
                                  },
                                ),
                                Visibility(
                                  visible: controller.visibilityCity,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: ColorPalette.danger,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          'Silahkan pilih kabupaten/kota',
                                          style: subTitle.copyWith(fontSize: 12, color: ColorPalette.secondary.withOpacity(0.7)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            width: Get.width,
                            height: 75,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorPalette.button,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  )),
                              onPressed: () {
                                if (controller.nameController.text.isEmpty ||
                                    controller.selectedProv == null ||
                                    controller.selectedCity == null
                                ) {
                                  if(controller.nameController.text.isEmpty) {
                                    controller.visibilityName = true;
                                  }
                                  if(controller.selectedProv == null) {
                                    controller.visibilityProv = true;
                                  }
                                  if(controller.selectedProv == null) {
                                    controller.visibilityCity = true;
                                  }

                                  controller.update();
                                }else{
                                  Get.showSnackbar(GetSnackBar(message: 'Success', duration: Duration(seconds: 3),));
                                }
                              },
                              child: Text(
                                  'Proses',
                                  style: title.copyWith(color: ColorPalette.white)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
            ),
          );
        }
    );
  }
}