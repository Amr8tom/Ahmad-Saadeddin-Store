// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/model/cart_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/my_cart/checkout_success_screen.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import '../../../core/controller/cart_controller/checkout_controller.dart';
import '../../widget/common_button.dart';
import 'cart_widget.dart';

class FinalizeWidget extends StatefulWidget {
  final TabController tabController;
  final CheckoutController checkoutController;

  const FinalizeWidget(
      {Key? key, required this.tabController, required this.checkoutController})
      : super(key: key);

  @override
  State<FinalizeWidget> createState() => _FinalizeWidgetState();
}

class _FinalizeWidgetState extends State<FinalizeWidget> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    widget.checkoutController.itemsList.clear();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Products".tr,
                style: pBold14,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Change".tr,
                  style: pMedium12.copyWith(
                      color: AppColor.cText,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: cartController.cartList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              CartItems data = cartController.cartList[index];
              print("productType========> ${data.meta!.productType}");
              if (data.meta!.productType == "variation") {
                widget.checkoutController.itemsList.add({"variation_id": data.id, 'quantity': data.quantity!.value});
              } else {
                widget.checkoutController.itemsList.add({"product_id": data.id, 'quantity': data.quantity!.value});
              }
              print("itemsList==========> ${widget.checkoutController.itemsList.value}");
              print("length=============> ${widget.checkoutController.itemsList.length}");
              return buildCartWidget(
                isCheckout: true,
                image: data.featuredImage,
                title: data.name,
                color: data.meta!.variation == null
                    ? null
                    : data.meta!.variation!.color,
                price: data.price,
                regularPrice: data.price,
              );
            },
          ),
          verticalSpace(10),
          buildTotalWidget(
              cartController.cartModel == null
                  ? '0.00'
                  : '${cartController.cartModel!.totals!.subtotal ?? 0}',
              cartController.cartModel!.itemCount,
              cartController.cartModel == null
                  ? '0.00'
                  : '${cartController.cartModel!.totals!.total ?? 0}'),
          verticalSpace(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery".tr,
                style: pBold14,
              ),
              TextButton(
                onPressed: () {
                  widget.tabController.animateTo(1);
                },
                child: Text(
                  "Change".tr,
                  style: pMedium12.copyWith(
                      color: AppColor.cText,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          buildDeliveryWidget(
              image: DefaultImages.fedExImage,
              label: "FedEx",
              title: widget.checkoutController.address_title.value,
              address:  widget.checkoutController.address_1.value),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment".tr,
                style: pBold14,
              ),
              TextButton(
                onPressed: () {
                  widget.tabController.animateTo(2);
                },
                child: Text(
                  "Change".tr,
                  style: pMedium12.copyWith(
                      color: AppColor.cText,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          buildDeliveryWidget(
            image: DefaultImages.masterCardImage,
            label: "Cash on delivery",
          ),
          verticalSpace(15),
          CommonIconBorderButton(
            onPressed: () {
              widget.checkoutController.addToOrder();
            },
            title: 'Finalize!'.tr,
            iconData: DefaultImages.arrowRightIcn,
            btnColor: AppColor.blueThemeColor,
            textColor: AppColor.cBtnTxt,
          )
        ],
      ),
    );
  }
}

Widget buildDeliveryWidget(
    {String? image, String? label, String? title, String? address}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      // height: 67.74,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColor.cBackGround,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.cBorder)),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(image!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(
              label!,
              style: pBold12.copyWith(fontSize: 10),
            ),
          ),
          title == null
              ? horizontalSpace(0)
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: pBold12.copyWith(fontSize: 10),
                      ),
                      verticalSpace(4),
                      Text(
                        address!,
                        style: pMedium10,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    ),
  );
}
