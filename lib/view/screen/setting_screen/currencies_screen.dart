// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding1.dart';
import 'package:gostore_app/core/controller/setting_controller/currencies_controller.dart';

class CurrenciesScreen extends StatelessWidget {
  CurrenciesScreen({Key? key}) : super(key: key);
  CurrenciesController currenciesController = Get.put(CurrenciesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar("Currencies".tr),
              verticalSpace(25),
              Text(
                "Change Currency".tr,
                style: pBold24.copyWith(fontSize: 20),
              ),
              verticalSpace(8),
              Text(
                "Which currency do you prefer?".tr,
                style: pMedium12.copyWith(color: AppColor.cGreyFont),
              ),
              verticalSpace(15),
              Obx(
                () {
                  print(currenciesController.currantIndex.value);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: currenciesController.currenciesList.length,
                    itemBuilder: (context, i) {
                      var data = currenciesController.currenciesList[i];
                      return GestureDetector(
                        onTap: () {
                          currenciesController.currantIndex.value = i;
                          currenciesController.currantIndex.refresh();
                        },
                        child: languageWidget(
                          title: data,
                          color: currenciesController.currantIndex.value == i
                              ? AppColor.blueThemeColor
                              : AppColor.cWhite,
                          bColor: currenciesController.currantIndex.value == i
                              ? AppColor.blueThemeColor
                              : AppColor.cBorder,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
