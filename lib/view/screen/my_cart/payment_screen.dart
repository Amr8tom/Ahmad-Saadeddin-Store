// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/cart_controller/checkout_controller.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';

import '../../../utils/colors.dart';
import '../../widget/common_button.dart';
import '../../widget/common_space_divider_widget.dart';
import 'shipping_screen.dart';

class PaymentWidget extends StatelessWidget {
  final TabController tabController;
  final CheckoutController checkoutController;

  PaymentWidget(
      {Key? key, required this.tabController, required this.checkoutController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Payment Service".tr,
            style: pBold14,
          ),
          verticalSpace(15),
          ListView.builder(
            itemCount: checkoutController.paymentDataList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var data = checkoutController.paymentDataList[index];
              return shippingCardWidget(
                value: data['value'].value,
                onChanged: () {
                  // data['value'].value = value;
                  for (int j = 0;
                      j < checkoutController.paymentDataList.length;
                      j++) {
                    if (index == j) {
                      data['value'].value = true;
                    } else {
                      checkoutController.paymentDataList[j]['value'].value =
                          false;
                    }
                  }
                  checkoutController.paymentDataList.refresh();
                },
                image: data['image'],
                label: data['label'],
              );
            },
          ),
          verticalSpace(15),
          CommonIconBorderButton(
            onPressed: () {
              tabController.animateTo(3);
            },
            title: 'Go to Preview'.tr,
            iconData: DefaultImages.arrowRightIcn,
            btnColor: AppColor.blueThemeColor,
            textColor: AppColor.cBtnTxt,
          )
        ],
      );
    });
  }
}
