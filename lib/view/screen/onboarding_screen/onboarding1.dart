// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/onboarding_controller/onboarding_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';

import '../../../utils/constant.dart';
import '../../../utils/prefer.dart';
import 'languages_widget.dart';

class OnBoarding1 extends StatefulWidget {
  OnBodingController onBodingController;

  OnBoarding1({Key? key, required this.onBodingController}) : super(key: key);

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) ?? 'en';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanTitle();
  }

  getLanTitle() {
    for (int i = 0; i < widget.onBodingController.languageList.length; i++) {
      var data = widget.onBodingController.languageList[i];
      if (data['languageCode'] == languageCode) {
        widget.onBodingController.selectedLanguage.value = data['title'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: Get.height * 0.12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome you GoStore".tr,
                style: pBold24,
              ),
              verticalSpace(8),
              Text(
                "GoStore is on the wat to serve you".tr,
                style: pMedium14.copyWith(color: AppColor.cGreyFont),
              ),
              // verticalSpace(8),
              // Text(
              //   "Select Language:".tr,
              //   style: pMedium14,
              // ),
              // verticalSpace(10),
              // CommonIconBorderButton(
              //     iconData: DefaultImages.dropDownIcn,
              //     title: widget.onBodingController.selectedLanguage.value,
              //     colorFilter: ColorFilter.mode(
              //         AppColor.blueThemeColor, BlendMode.srcIn),
              //     onPressed: () {
              //       showModalBottomSheet(
              //           backgroundColor: AppColor.cTransparent,
              //           barrierColor: AppColor.cDarkGrey,
              //           context: context,
              //           isScrollControlled: true,
              //           isDismissible: false,
              //           enableDrag: false,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.vertical(
              //                   top: Radius.circular(20))),
              //           builder: (context) {
              //             return ChangeLanguageBottomSheet(
              //               onBodingController: widget.onBodingController,
              //             );
              //           });
              //     }),
              assetSvdImageWidget(
                  image: DefaultImages.onlineShoppingSvg,
                  width: 374,
                  height: 350
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout".tr}.",
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

class ChangeLanguageBottomSheet extends StatelessWidget {
  OnBodingController onBodingController;

  ChangeLanguageBottomSheet({Key? key, required this.onBodingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: CommonIconBorderButton(
              width: 125,
              radius: 20,
              iconData: DefaultImages.cancelIcn,
              btnColor: AppColor.cDarkGrey,
              title: 'Cancel'.tr,
              onPressed: () {
                Get.back();
              }),
        ),
        verticalSpace(15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppColor.cBackGround),
          child: Padding(
            padding: EdgeInsets.only(
              top: Get.height * 0.05,
              right: 22,
              left: 22,
              bottom: 22,
            ),
            child: SingleChildScrollView(
              child: LanguagesWidget(
                isBack: true,
                onBodingController: onBodingController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget languageWidget(
    {String? image, String? title, Color? color, Color? bColor}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      height: 55,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bColor ?? AppColor.cBorder)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              image == null
                  ? SizedBox(
                      width: 0,
                      height: 0,
                    )
                  : Image.asset(image),
              horizontalSpace(15),
              Text(
                title!,
                style: pMedium12,
              ),
            ],
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.cBorder, width: 1),
                shape: BoxShape.circle),
            padding: EdgeInsets.all(01.5),
            child: CircleAvatar(
              backgroundColor: color ?? AppColor.cWhite,
            ),
          ),
        ],
      ),
    ),
  );
}
