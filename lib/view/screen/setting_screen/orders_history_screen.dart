// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/model/order_history_model.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/view/screen/setting_screen/order_history_detail_screen.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/setting_controller/order_history_controller.dart';

class OrdersHistoryScreen extends StatefulWidget {
  OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  OrderHistoryController orderHistoryController = Get.put(OrderHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOrderData();
    });
  }

  getOrderData() {
    orderHistoryController.getOrderHistory();
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
              buildAppBar("Orders History".tr),
              verticalSpace(15),
              Obx(() {
                print(orderHistoryController.currantIndex.value);
                return orderHistoryController.orderHistoryList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: orderHistoryController.orderHistoryList.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            OrdersHistoryModel history = orderHistoryController.orderHistoryList[index];
                            return buildOrdersHistory(
                              orderCode: history.orderKey,
                              date: dateFormatted(
                                  date: history.dateCreated!, formatType: formatForDateTime(FormatType.ddMMMYYYY)),
                              totalProduct: history.lineItems!.length.toString(),
                              totalPrice: history.total,
                              address: '${history.billing!.address1!}, ${history.billing!.city!}',
                              payment: history.paymentMethodTitle,
                              status: history.status,
                              shippingMethod: history.shippingLines!.isNotEmpty
                                  ? history.shippingLines!.first.methodTitle
                                  : 'FedEx',
                              onTap: () {
                                orderHistoryController.currantIndex.value = index;
                                Get.to(() => OrderHistoryDetailScreen(
                                      orderId: history.id.toString(),
                                    ));
                              },
                              isSelected: orderHistoryController.currantIndex.value == index,
                            );
                          },
                        ),
                      )
                    : orderHistoryController.isEmptyHistoryList.value == true
                        ? SizedBox(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Text(
                                "Order history not found!",
                                style: pSemiBold18.copyWith(color: AppColor.cGreyFont),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrdersHistory({
    String? orderCode,
    String? date,
    String? totalProduct,
    String? totalPrice,
    String? address,
    String? payment,
    String? status,
    String? shippingMethod,
    Function()? onTap,
    bool? isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected == true ? AppColor.cLightBlue : AppColor.cBackGround,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected == true ? AppColor.blueThemeColor : AppColor.cBorder,
          ),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    orderCode!,
                    style: pBold24.copyWith(fontSize: 20),
                  ),
                ),
                Text(
                  date!,
                  style: pMedium12,
                ),
              ],
            ),
            verticalSpace(5),
            RichText(
              text: TextSpan(
                text: '$totalProduct products for ',
                style: pBold12.copyWith(fontSize: 10.98),
                children: [
                  TextSpan(
                    text: '\$$totalPrice',
                    style: pBold12.copyWith(color: AppColor.cText, fontSize: 10.98),
                  )
                ],
              ),
            ),
            verticalSpace(15),
            Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 158, minWidth: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address:'.tr,
                        style: pBold12.copyWith(fontSize: 10.98),
                      ),
                      Text(address!, style: pMedium10),
                      verticalSpace(6),
                      Text(
                        'Status:'.tr,
                        style: pBold12.copyWith(fontSize: 10.98),
                      ),
                      Text(status!, style: pMedium10),
                    ],
                  ),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment:'.tr,
                      style: pBold12.copyWith(fontSize: 10.98),
                    ),
                    Text(payment!, style: pMedium10),
                    verticalSpace(6),
                    Text(
                      'Shipping Method:'.tr,
                      style: pBold12.copyWith(fontSize: 10.98),
                    ),
                    Text(shippingMethod!, style: pMedium10),
                  ],
                ),
              ],
            ),
            verticalSpace(10),
            CommonIconBorderButton(
              title: 'More information\'s...'.tr,
              onPressed: onTap,
              height: 40,
              btnColor: isSelected == true ? AppColor.cLightBlue : AppColor.cBackGround,
            ),
          ],
        ),
      ),
    );
  }
}
