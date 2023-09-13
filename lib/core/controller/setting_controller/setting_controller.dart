// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/gostore_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/view/screen/setting_screen/wishlist_screen.dart';
import 'package:gostore_app/view/screen/setting_screen/languages_screen.dart';
import 'package:gostore_app/view/screen/setting_screen/orders_history_screen.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

import '../../../utils/text_style.dart';

class SettingController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxBool isNotification = true.obs;

  List itemList = [
    {"icon": DefaultImages.unlikeIcn, "title": 'My Wishlist'.tr},
    // {"icon": DefaultImages.notificationIcn, "title": 'Get Notification'.tr},
    {"icon": DefaultImages.earthIcn, "title": 'Languages'.tr},
    // {"icon": DefaultImages.dollarIcn, "title": 'Currencies'.tr},
    {"icon": DefaultImages.historyIcn, "title": 'Order History'.tr},
    {"icon": DefaultImages.themeIcn, "title": 'Dark Theme'.tr},
  ];

  onTapSwitchCase(int index, BuildContext context) {
    switch (index) {
      case 0:
        Get.to(() => WishlistScreen());
        break;
      case 1:
        Get.to(() => LanguagesScreen());
        break;
      // case 3:
      //   Get.to(() => CurrenciesScreen());
      // break;
      case 2:
        Get.to(() => OrdersHistoryScreen());
        break;
      case 3:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GetBuilder(
                init: GoStoreAppController(),
                builder: (goStoreAppController) {
                  return AlertDialog(
                    backgroundColor: AppColor.cBackGround,
                    title: Text(
                      "Theme".tr,
                      style: pBold24.copyWith(
                        color: AppColor.cFont,
                        fontSize: 14,
                      ),
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              goStoreAppController.changeTheme('blue');
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColor.blueColor,
                            )),
                        horizontalSpace(15),
                        GestureDetector(
                            onTap: () {
                              goStoreAppController.changeTheme('orange');
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: OrangeThemeColor.orangeColor,
                            )),
                        horizontalSpace(15),
                        GestureDetector(
                            onTap: () {
                              goStoreAppController.changeTheme('black');
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: BlackThemeColor.blackColor,
                            )),
                      ],
                    ),
                    titlePadding: EdgeInsets.all(20),
                    contentPadding: EdgeInsets.all(20),
                  );
                });
          },
        );
        break;
    }
  }
}
