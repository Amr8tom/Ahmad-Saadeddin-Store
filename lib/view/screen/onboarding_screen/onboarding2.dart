// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/onboarding_controller/onboarding_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding1.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';

class OnBoarding2 extends StatelessWidget {
  OnBodingController onBodingController = Get.find();

  OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: Get.height * 0.06),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: CommonIconBorderButton(
              //       iconData: DefaultImages.dropDownIcn,
              //       title: onBodingController.selectedLanguage.value,
              //       height: 45,
              //       width: 120,
              //       colorFilter: ColorFilter.mode(
              //           AppColor.blueThemeColor, BlendMode.srcIn),
              //       onPressed: () {
              //         showModalBottomSheet(
              //             backgroundColor: AppColor.cTransparent,
              //             barrierColor: AppColor.cDarkGrey,
              //             context: context,
              //             isScrollControlled: true,
              //             isDismissible: false,
              //             enableDrag: false,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.vertical(
              //                     top: Radius.circular(20))),
              //             builder: (context) {
              //               return ChangeLanguageBottomSheet(
              //                 onBodingController: onBodingController,
              //               );
              //             });
              //       }),
              // ),
              // verticalSpace(15),
              Text(
                "Connect Surrounding World".tr,
                style: pBold24,
              ),
              verticalSpace(8),
              Text(
                "GoStore is on the wat to serve you".tr,
                style: pMedium14.copyWith(color: AppColor.cGreyFont),
              ),
              verticalSpace(8),
              assetSvdImageWidget(
                  image: DefaultImages.courierOnTheWaySvg,
                  width: 374,
                  height: 374),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.".tr,
                  style: pMedium14.copyWith(color: AppColor.cGreyFont),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
