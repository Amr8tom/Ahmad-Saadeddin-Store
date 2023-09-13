// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/cart_controller/checkout_controller.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';

import '../../../utils/colors.dart';
import '../../widget/common_button.dart';
import '../../widget/common_space_divider_widget.dart';

class ShippingWidget extends StatelessWidget {
  final TabController tabController;
  final CheckoutController checkoutController;

  ShippingWidget(
      {Key? key, required this.tabController, required this.checkoutController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Shipping Service".tr,
            style: pBold14,
          ),
          verticalSpace(15),
          ListView.builder(
            itemCount: checkoutController.shippingDataList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var data = checkoutController.shippingDataList[index];
              return shippingCardWidget(
                value: data['value'].value,
                onChanged: () {
                  // data['value'].value = value;
                  for (int j = 0;
                      j < checkoutController.shippingDataList.length;
                      j++) {
                    if (index == j) {
                      data['value'].value = true;
                    } else {
                      checkoutController.shippingDataList[j]['value'].value =
                          false;
                    }
                  }
                  checkoutController.shippingDataList.refresh();
                },
                image: data['image'],
                label: data['label'],
              );
            },
          ),
          verticalSpace(15),
          CommonIconBorderButton(
            onPressed: () {
              tabController.animateTo(2);
            },
            title: 'Go to Payment'.tr,
            iconData: DefaultImages.arrowRightIcn,
            btnColor: AppColor.blueThemeColor,
            textColor: AppColor.cBtnTxt,
          )
        ],
      );
    });
  }
}

Widget shippingCardWidget(
    {final bool? value,
    final Function()? onChanged,
    String? image,
    String? label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: onChanged,
      child: Container(
        height: 67.74,
        width: Get.width,
        decoration: BoxDecoration(
            color:value==true? AppColor.cLightBlue:AppColor.cBackGround,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color:value==true?  AppColor.blueThemeColor:AppColor.cBorder)),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {},
              checkColor: AppColor.cBtnTxt,
              activeColor: AppColor.blueThemeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: BorderSide(color: AppColor.blueThemeColor, width: 1.5),
            ),
            horizontalSpace(10),
            Image(image: AssetImage(image!)),
            horizontalSpace(10),
            Text(
              label!,
              style: pBold12.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    ),
  );
}
