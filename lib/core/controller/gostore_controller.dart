// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/config/themes/theme.dart';

class GoStoreAppController extends GetxController {
  ThemeMode mode = ThemeMode.dark;
  String isDarkTheme = Prefs.getString(AppConstant.THEME) ?? "blue";

  void changeTheme(String theme) {
    Prefs.setString(AppConstant.THEME, theme == '' ? "blue" : theme);
    isDarkTheme = Prefs.getString(AppConstant.THEME);
    print('isDarkTheme::: $isDarkTheme');
    if (isDarkTheme == 'blue') {
      AppBlueTheme.lightThemeColor();
      AppBlueTheme.lightThemeImage();
      update();
    } else if (isDarkTheme == 'orange') {
      AppBlueTheme.lightThemeColor();
      AppOrangeTheme.lightThemeColor();
      AppBlueTheme.lightThemeImage();
      AppOrangeTheme.lightThemeImage();
      update();
    } else {
      AppBlueTheme.lightThemeColor();
      AppDarkTheme.darkThemeColor();
      AppBlueTheme.lightThemeImage();
      AppDarkTheme.darkThemeImage();
      update();
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // changeTheme(getStorage!.read('darkmode'));
    changeTheme(isDarkTheme);
  }
}
