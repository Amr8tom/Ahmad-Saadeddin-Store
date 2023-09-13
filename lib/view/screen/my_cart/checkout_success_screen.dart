// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';

import '../../../utils/images.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  final String orderId;
  const CheckoutSuccessScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBar( "Checkout".tr),
              verticalSpace(
                Get.height * 0.08,
              ),
              Text(
                "It’s Ordered!".tr,
                style: pBold24,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Text(
                  "Your order".tr +" #$orderId "+"was successfully placed!".tr,
                  style: pMedium14.copyWith(color: AppColor.cGreyFont),
                  textAlign: TextAlign.center,
                ),
              ),
              assetSvdImageWidget(
                image: DefaultImages.onlineShopIcn,
              ),
              verticalSpace(
                Get.height * 0.08,
              ),
              CommonIconBorderButton(
                title: 'Back to Shop'.tr,
                iconData: DefaultImages.arrowRightIcn,
                onPressed: () {
                  Get.offAll(() => DashBoardManagerScreen());
                },
                textColor: AppColor.cBtnTxt,
                btnColor: AppColor.blueThemeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
