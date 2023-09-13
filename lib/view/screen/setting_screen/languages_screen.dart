// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/onboarding_screen/languages_widget.dart';
import 'package:gostore_app/core/controller/onboarding_controller/onboarding_controller.dart';

class LanguagesScreen extends StatelessWidget {
  LanguagesScreen({Key? key}) : super(key: key);
  OnBodingController onBodingController = Get.put(OnBodingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              buildAppBar( "Languages".tr),
              verticalSpace(25),
              LanguagesWidget(
                  onBodingController: onBodingController, isBack: false),
            ],
          ),
        ),
      ),
    );
  }

}
