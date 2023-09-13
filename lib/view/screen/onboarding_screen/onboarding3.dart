// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/auth/sign_up_screen.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding1.dart';
import 'package:gostore_app/core/controller/onboarding_controller/onboarding_controller.dart';

class OnBoarding3 extends StatelessWidget {
  OnBodingController onBodingController = Get.find();

  OnBoarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: Get.height * 0.06),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Align(alignment: Alignment.centerRight,
              //   child: CommonBorderButton(
              //       title: getLanguage(onBodingController.selectedLanguage.value.toUpperCase()),
              //       height: 45,width: 120,
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
                "Let’s Get Started".tr,
                style: pBold24,
              ),
              verticalSpace(8),
              Text(
                "GoStore is on the wat to serve you".tr,
                textAlign: TextAlign.center,
                style: pMedium14.copyWith(color: AppColor.cGreyFont),
              ),
              verticalSpace(8),
              assetSvdImageWidget(
                  image: DefaultImages.paymentMethodSvg,
                  width: 265,
                  height: 265),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Waiting no more, let’s see what we get!".tr,
                  style: pMedium14.copyWith(color: AppColor.cGreyFont),
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(10),
              CommonButton(title: 'Sign In'.tr,onPressed: (){Get.offAll(LoginScreen( isBack: false,));},height: 56),
              verticalSpace(10),
              CommonBorderButton(title: 'Sign Up'.tr,onPressed: (){Get.offAll(()=>SignUpScreen(isBack: false,));
              },height: 56,bColor: AppColor.cBorder,textColor: AppColor.cFont),
            ],
          ),
        ),
      ),
    );
  }
  String getLanguage(String string){
    return string[0] + string[1];
  }
}