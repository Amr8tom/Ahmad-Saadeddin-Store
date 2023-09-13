// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print

import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';

import 'onboarding1.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/onboarding_controller/onboarding_controller.dart';

class LanguagesWidget extends StatelessWidget {
  OnBodingController onBodingController;
final bool isBack;
  LanguagesWidget({Key? key, required this.onBodingController, required this.isBack})
      : super(key: key);

  String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) ?? 'en';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Language".tr,
          style: pBold24.copyWith(fontSize: 20),
        ),
        verticalSpace(8),
        Text(
          "Which language do you prefer?".tr,
          style: pMedium12.copyWith(color: AppColor.cGreyFont),
        ),
        verticalSpace(15),
        Obx(() {
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: onBodingController.languageList.length,
              itemBuilder: (context, i) {
                var data = onBodingController.languageList[i];
                return GestureDetector(
                  onTap: () {
                    onBodingController.selectedLanguageIndex.value = i;
                    onBodingController.selectedLanguage.value =
                        data['title'];
                    onBodingController.selectedLanguageIndex.refresh();
                    print("++${data['local']}");
                    onBodingController.updateLanguage(data['local']);
                    if (isBack == true) {
                      Get.back();
                    }
                  },
                  child: languageWidget(
                    image: data['image'],
                    title: data['title'],
                    color: data['languageCode'] == languageCode
                        ? AppColor.blueThemeColor
                        : AppColor.cWhite,
                    bColor: data['languageCode'] == languageCode
                        ? AppColor.blueThemeColor
                        : AppColor.cBorder,
                  ),
                );
              });
        }),
      ],
    );
  }
}
