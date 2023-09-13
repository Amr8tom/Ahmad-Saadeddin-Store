// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/view/screen/my_cart/address_widget.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/my_cart/payment_screen.dart';
import 'package:gostore_app/view/screen/my_cart/shipping_screen.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/cart_controller/checkout_controller.dart';

import 'finalize_screen.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key? key,}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with TickerProviderStateMixin {
  CheckoutController checkoutController = Get.put(CheckoutController());
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

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
              buildAppBar("Checkout".tr),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TabBar(
                  controller: tabController,
                  tabs: checkoutController.tabBarList
                      .map(
                        (e) => Tab(
                          text: e,
                        ),
                      )
                      .toList(),
                  labelStyle: pMedium12,
                  labelColor: AppColor.cText,
                  unselectedLabelStyle: pMedium12,
                  unselectedLabelColor: AppColor.cGreyFont,
                  dividerColor: AppColor.cDivider,
                  indicatorColor: AppColor.blueThemeColor,
                  automaticIndicatorColorAdjustment: false,
                ),
              ),
              verticalSpace(10),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AddressWidget(
                        tabController: tabController!,
                        checkoutController: checkoutController),
                    ShippingWidget(
                        tabController: tabController!,
                        checkoutController: checkoutController),
                    PaymentWidget(
                        tabController: tabController!,
                        checkoutController: checkoutController),
                    FinalizeWidget(
                        tabController: tabController!,
                        checkoutController: checkoutController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
