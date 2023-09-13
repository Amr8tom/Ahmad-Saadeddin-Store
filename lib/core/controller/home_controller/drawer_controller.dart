// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:get/get.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/screen/setting_screen/blog_screen.dart';
import 'package:gostore_app/view/screen/setting_screen/setting_screen.dart';

class MyDrawerController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxList itemList = [
    DefaultImages.homeIcn,
    DefaultImages.gridIcn,
    DefaultImages.blogIcn,
    DefaultImages.userIcn,
    DefaultImages.logOutIcn,
  ].obs;

  onTapSwitchCase(int index) {
    String accessToken = Prefs.getToken();
    switch (index) {
      case 0:
        Get.back();
        break;
      case 1:
        Get.back();
        Get.offAll(DashBoardManagerScreen(currantIndex: 1));
        break;
      case 2:
        Get.back();
        Get.to(() => BlogScreen());
        break;
      case 3:
        // Get.back();
        accessToken == ''
            ? Get.to(() => LoginScreen(
                  isBack: true,
                  page: 0,
                ))
            : Get.to(() => SettingScreen());
        break;
      case 4:
        Prefs.clear();
        Get.offAll(() => LoginScreen(
              isBack: false,
            ));
        break;
    }
  }
}
