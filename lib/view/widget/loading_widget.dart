// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/colors.dart';

class Loader {
  static showLoader() {
    Get.dialog(LoadingWidget());
  }

  static hideLoader() {
    Get.back(closeOverlays: true);
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColor.blueThemeColor),
    );
  }
}
